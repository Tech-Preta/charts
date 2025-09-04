# 🏆 Melhores Práticas para Helm Charts

Este documento contém as melhores práticas para desenvolvimento, manutenção e distribuição de Helm Charts no repositório Tech-Preta/charts.

## 📋 Índice

- [Estrutura de Charts](#-estrutura-de-charts)
- [Nomenclatura](#-nomenclatura)
- [Segurança](#-segurança)
- [Performance](#-performance)
- [Manutenibilidade](#-manutenibilidade)
- [Testes](#-testes)
- [Documentação](#-documentação)

## 🏗️ Estrutura de Charts

### Estrutura Recomendada

```
meu-chart/
├── Chart.yaml              # Metadados do chart
├── Chart.lock              # Lock de dependências (se houver)
├── values.yaml             # Valores padrão
├── values.schema.json      # Schema de validação (opcional)
├── README.md               # Documentação
├── CHANGELOG.md            # Histórico de mudanças
├── requirements.yaml       # Dependências (Helm 2, descontinuado)
├── charts/                 # Charts de dependência local
├── templates/              # Templates Kubernetes
│   ├── _helpers.tpl       # Funções auxiliares
│   ├── NOTES.txt          # Instruções pós-instalação
│   ├── deployment.yaml    # Deployment principal
│   ├── service.yaml       # Service
│   ├── ingress.yaml       # Ingress (se aplicável)
│   ├── configmap.yaml     # ConfigMaps
│   ├── secret.yaml        # Secrets
│   ├── serviceaccount.yaml # ServiceAccount
│   ├── rbac.yaml          # RBAC (se necessário)
│   ├── hpa.yaml           # HorizontalPodAutoscaler
│   ├── pdb.yaml           # PodDisruptionBudget
│   ├── networkpolicy.yaml # Network Policy
│   └── tests/             # Testes do Helm
│       └── test-connection.yaml
├── crds/                  # Custom Resource Definitions
└── files/                 # Arquivos estáticos
```

### Templates Essenciais

#### _helpers.tpl
```yaml
{{/*
Expand the name of the chart.
*/}}
{{- define "meu-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "meu-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "meu-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "meu-chart.labels" -}}
helm.sh/chart: {{ include "meu-chart.chart" . }}
{{ include "meu-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- range $key, $value := .Values.commonLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "meu-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "meu-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "meu-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "meu-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "meu-chart.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion | toString -}}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else }}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end }}
{{- end }}
```

#### NOTES.txt
```yaml
1. Get the application URL by running these commands:
{{- if .Values.ingress.enabled }}
{{- range $host := .Values.ingress.hosts }}
  {{- range .paths }}
  http{{ if $.Values.ingress.tls }}s{{ end }}://{{ $host.host }}{{ .path }}
  {{- end }}
{{- end }}
{{- else if contains "NodePort" .Values.service.type }}
  export NODE_PORT=$(kubectl get --namespace {{ .Release.Namespace }} -o jsonpath="{.spec.ports[0].nodePort}" services {{ include "meu-chart.fullname" . }})
  export NODE_IP=$(kubectl get nodes --namespace {{ .Release.Namespace }} -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
{{- else if contains "LoadBalancer" .Values.service.type }}
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get --namespace {{ .Release.Namespace }} svc -w {{ include "meu-chart.fullname" . }}'
  export SERVICE_IP=$(kubectl get svc --namespace {{ .Release.Namespace }} {{ include "meu-chart.fullname" . }} --template "{{"{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}"}}")
  echo http://$SERVICE_IP:{{ .Values.service.port }}
{{- else if contains "ClusterIP" .Values.service.type }}
  export POD_NAME=$(kubectl get pods --namespace {{ .Release.Namespace }} -l "{{ include "meu-chart.selectorLabels" . }}" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace {{ .Release.Namespace }} $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace {{ .Release.Namespace }} port-forward $POD_NAME 8080:$CONTAINER_PORT
{{- end }}
```

## 📛 Nomenclatura

### Nomes de Charts

```yaml
# ✅ Bom
name: nginx-ingress
name: postgres-operator
name: monitoring-stack

# ❌ Evitar
name: nginx_ingress
name: PostgresOperator
name: monitoring-Stack
```

### Nomes de Resources

```yaml
# ✅ Usar helpers para consistência
metadata:
  name: {{ include "meu-chart.fullname" . }}
  labels:
    {{- include "meu-chart.labels" . | nindent 4 }}

# ❌ Hardcoded
metadata:
  name: meu-app
  labels:
    app: meu-app
```

### Nomes de Values

```yaml
# ✅ Estrutura hierárquica clara
image:
  registry: docker.io
  repository: nginx
  tag: "1.21"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80
  targetPort: http

# ❌ Nomes confusos
nginxImage: nginx:1.21
svcType: ClusterIP
portNumber: 80
```

## 🔒 Segurança

### SecurityContext

```yaml
# ✅ Sempre configurar SecurityContext
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  runAsUser: 1000
  runAsGroup: 3000
  fsGroup: 2000

# Template
spec:
  securityContext:
    {{- toYaml .Values.podSecurityContext | nindent 8 }}
  containers:
  - name: {{ .Chart.Name }}
    securityContext:
      {{- toYaml .Values.securityContext | nindent 12 }}
```

### Secrets Management

```yaml
# ✅ Usar secrets apropriadamente
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "meu-chart.fullname" . }}-secret
type: Opaque
data:
  {{- if .Values.auth.password }}
  password: {{ .Values.auth.password | b64enc | quote }}
  {{- end }}
  {{- if .Values.auth.existingSecret }}
  # Referenciar secret existente
  {{- end }}

# values.yaml
auth:
  password: ""
  existingSecret: ""
  existingSecretKey: "password"
```

### RBAC

```yaml
# ✅ RBAC mínimo necessário
{{- if .Values.rbac.create }}
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{ include "meu-chart.fullname" . }}
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
{{- end }}

# values.yaml
rbac:
  create: false
  rules: []
```

### Network Policies

```yaml
# ✅ Isolamento de rede quando necessário
{{- if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ include "meu-chart.fullname" . }}
spec:
  podSelector:
    matchLabels:
      {{- include "meu-chart.selectorLabels" . | nindent 6 }}
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: allowed-app
{{- end }}
```

## ⚡ Performance

### Resource Management

```yaml
# ✅ Sempre definir resources
resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi

# Template
resources:
  {{- toYaml .Values.resources | nindent 12 }}

# values.yaml com valores sensatos
resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

### Probes de Saúde

```yaml
# ✅ Configurar probes apropriadas
livenessProbe:
  httpGet:
    path: /health
    port: http
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3

readinessProbe:
  httpGet:
    path: /ready
    port: http
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 3

startupProbe:
  httpGet:
    path: /health
    port: http
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 30
```

### HPA (Horizontal Pod Autoscaler)

```yaml
# ✅ HPA configurável
{{- if .Values.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "meu-chart.fullname" . }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "meu-chart.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas }}
  metrics:
    {{- if .Values.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if .Values.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetMemoryUtilizationPercentage }}
    {{- end }}
{{- end }}
```

## 🔧 Manutenibilidade

### Conditionals

```yaml
# ✅ Usar conditionals para recursos opcionais
{{- if .Values.ingress.enabled -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
# ...
{{- end }}

# ✅ Conditionals em blocos
{{- if and .Values.persistence.enabled .Values.persistence.storageClass }}
storageClassName: {{ .Values.persistence.storageClass }}
{{- end }}
```

### Loops

```yaml
# ✅ Loops para configurações repetitivas
{{- range .Values.ingress.hosts }}
- host: {{ .host | quote }}
  http:
    paths:
    {{- range .paths }}
    - path: {{ .path }}
      pathType: {{ .pathType }}
      backend:
        service:
          name: {{ include "meu-chart.fullname" $ }}
          port:
            number: {{ $.Values.service.port }}
    {{- end }}
{{- end }}
```

### Validação

```yaml
# ✅ Validações importantes
{{- if not .Values.image.repository }}
{{- fail "image.repository is required" }}
{{- end }}

{{- if and .Values.persistence.enabled (not .Values.persistence.storageClass) }}
{{- fail "persistence.storageClass is required when persistence is enabled" }}
{{- end }}
```

## 🧪 Testes

### Testes de Conexão

```yaml
# templates/tests/test-connection.yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "meu-chart.fullname" . }}-test"
  labels:
    {{- include "meu-chart.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
    "helm.sh/hook-weight": "1"
    "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
spec:
  restartPolicy: Never
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "meu-chart.fullname" . }}:{{ .Values.service.port }}']
      resources:
        limits:
          cpu: 100m
          memory: 128Mi
        requests:
          cpu: 100m
          memory: 128Mi
```

### Testes Funcionais

```yaml
# templates/tests/test-functionality.yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "meu-chart.fullname" . }}-func-test"
  annotations:
    "helm.sh/hook": test
spec:
  restartPolicy: Never
  containers:
    - name: curl
      image: curlimages/curl:latest
      command:
        - /bin/sh
        - -c
        - |
          set -e
          echo "Testing basic functionality..."
          curl -f http://{{ include "meu-chart.fullname" . }}:{{ .Values.service.port }}/health
          echo "Health check passed!"
          
          echo "Testing API endpoint..."
          curl -f http://{{ include "meu-chart.fullname" . }}:{{ .Values.service.port }}/api/v1/status
          echo "API test passed!"
```

### Executar Testes

```bash
# Instalar chart
helm install test-release charts/meu-chart/

# Executar testes
helm test test-release

# Cleanup
helm uninstall test-release
```

## 📚 Documentação

### README.md Template

```markdown
# Chart Name

Breve descrição do chart.

## TL;DR

```bash
helm repo add techpreta https://tech-preta.github.io/charts/
helm install my-release techpreta/chart-name
```

## Introdução

Descrição detalhada da aplicação e do que o chart faz.

## Pré-requisitos

- Kubernetes 1.19+
- Helm 3.0+
- Recursos específicos necessários

## Instalação

### Instalação Básica

```bash
helm install my-release techpreta/chart-name
```

### Instalação com Configurações Customizadas

```bash
helm install my-release techpreta/chart-name \
  --set image.tag=1.2.3 \
  --set replicaCount=3
```

## Configuração

| Parâmetro | Descrição | Padrão |
|-----------|-----------|---------|
| `image.repository` | Repositório da imagem | `nginx` |
| `image.tag` | Tag da imagem | `1.21` |
| `replicaCount` | Número de réplicas | `1` |

## Exemplos

### Exemplo 1: Configuração Básica
### Exemplo 2: Configuração Avançada

## Troubleshooting

### Problema Comum 1
### Problema Comum 2

## Atualização

### De v1.x para v2.x

## Desinstalação

```bash
helm uninstall my-release
```
```

### Values Schema (Opcional)

```json
{
  "$schema": "https://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "image": {
      "type": "object",
      "properties": {
        "repository": {
          "type": "string"
        },
        "tag": {
          "type": "string"
        },
        "pullPolicy": {
          "type": "string",
          "enum": ["Always", "IfNotPresent", "Never"]
        }
      },
      "required": ["repository"]
    },
    "replicaCount": {
      "type": "integer",
      "minimum": 1
    }
  },
  "required": ["image"]
}
```

## ✅ Checklist de Qualidade

### Antes de Publicar

- [ ] Chart passa no `helm lint`
- [ ] Templates renderizam corretamente
- [ ] Values.yaml tem valores sensatos
- [ ] README.md está completo
- [ ] Testes funcionam
- [ ] SecurityContext configurado
- [ ] Resources definidos
- [ ] Probes de saúde configuradas
- [ ] Labels e anotações corretas
- [ ] Versioning seguindo SemVer

### Revisão de Código

- [ ] Nomenclatura consistente
- [ ] Helpers reutilizados
- [ ] Conditionals apropriadas
- [ ] Documentação atualizada
- [ ] Breaking changes documentados
- [ ] Compatibilidade verificada

---

Desenvolvido com ❤️ pela [Tech-Preta](https://github.com/Tech-Preta)
