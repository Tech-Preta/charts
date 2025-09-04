# ⚡ Referência Rápida - Helm Charts

Guia de referência rápida para comandos e procedimentos mais comuns.

## 🚀 Comandos Essenciais

### Desenvolvimento

```bash
# Criar novo chart
helm create meu-chart

# Lint do chart
helm lint charts/meu-chart/

# Debug de template
helm template test charts/meu-chart/ --debug

# Dry run
helm install test charts/meu-chart/ --dry-run --debug

# Validar valores
helm template test charts/meu-chart/ --values values-custom.yaml
```

### Empacotamento

```bash
# Empacotar chart
helm package charts/meu-chart/ --destination .

# Empacotar com versão específica
helm package charts/meu-chart/ --version 1.2.3 --destination .

# Atualizar index
helm repo index . --url https://tech-preta.github.io/charts/

# Merge com index existente
helm repo index . --url https://tech-preta.github.io/charts/ --merge index.yaml
```

### Teste e Instalação

```bash
# Instalar localmente
helm install test-release charts/meu-chart/

# Instalar com valores customizados
helm install test-release charts/meu-chart/ --values custom-values.yaml

# Executar testes
helm test test-release

# Desinstalar
helm uninstall test-release
```

### Repositório

```bash
# Adicionar repositório
helm repo add techpreta https://tech-preta.github.io/charts/

# Atualizar repositórios
helm repo update

# Instalar do repositório
helm install meu-release techpreta/meu-chart

# Pesquisar charts
helm search repo techpreta
```

## 📁 Estrutura de Arquivos

### Chart Mínimo
```
meu-chart/
├── Chart.yaml
├── values.yaml
├── README.md
└── templates/
    ├── _helpers.tpl
    ├── deployment.yaml
    ├── service.yaml
    ├── NOTES.txt
    └── tests/
        └── test-connection.yaml
```

### Chart Completo
```
meu-chart/
├── Chart.yaml
├── Chart.lock
├── values.yaml
├── values.schema.json
├── README.md
├── CHANGELOG.md
├── requirements.yaml
├── charts/
├── crds/
├── files/
└── templates/
    ├── _helpers.tpl
    ├── NOTES.txt
    ├── configmap.yaml
    ├── deployment.yaml
    ├── hpa.yaml
    ├── ingress.yaml
    ├── networkpolicy.yaml
    ├── pdb.yaml
    ├── rbac.yaml
    ├── secret.yaml
    ├── service.yaml
    ├── serviceaccount.yaml
    └── tests/
        ├── test-connection.yaml
        └── test-functionality.yaml
```

## 🔧 Templates Úteis

### Chart.yaml
```yaml
apiVersion: v2
name: meu-chart
description: Descrição do chart
version: 0.1.0
appVersion: "1.0.0"
type: application
keywords: [keyword1, keyword2]
maintainers:
  - name: Nome
    email: email@exemplo.com
home: https://github.com/projeto
sources: [https://github.com/fonte]
icon: https://exemplo.com/icon.png
```

### values.yaml Básico
```yaml
replicaCount: 1

image:
  repository: nginx
  tag: "1.21"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false
  className: ""
  annotations: {}
  hosts: []
  tls: []

resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi

autoscaling:
  enabled: false
  minReplicas: 1
  maxReplicas: 100
  targetCPUUtilizationPercentage: 80

nodeSelector: {}
tolerations: []
affinity: {}
```

### Helper Básico
```yaml
{{- define "meu-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

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

{{- define "meu-chart.labels" -}}
helm.sh/chart: {{ include "meu-chart.chart" . }}
{{ include "meu-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "meu-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "meu-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
```

### Deployment Básico
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "meu-chart.fullname" . }}
  labels:
    {{- include "meu-chart.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "meu-chart.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "meu-chart.selectorLabels" . | nindent 8 }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
```

## 🏷️ Versionamento Rápido

### Incrementar Versão
```bash
# PATCH (0.1.0 → 0.1.1) - Bug fixes
# MINOR (0.1.1 → 0.2.0) - Novas features
# MAJOR (0.2.0 → 1.0.0) - Breaking changes
```

### Estratégia por Ambiente
```bash
# Desenvolvimento: 0.1.x
# Staging: 0.2.x
# Produção: 1.x.x
```

## 🧪 Testes Rápidos

### Teste de Conexão
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "meu-chart.fullname" . }}-test"
  annotations:
    "helm.sh/hook": test
spec:
  restartPolicy: Never
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "meu-chart.fullname" . }}:{{ .Values.service.port }}']
```

### Executar Testes
```bash
helm install test-release charts/meu-chart/
helm test test-release
helm uninstall test-release
```

## 🔒 Segurança Rápida

### SecurityContext
```yaml
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop: [ALL]
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  runAsUser: 1000
```

### Resources
```yaml
resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi
```

## 🚨 Troubleshooting

### Problemas Comuns
```bash
# Erro de lint
helm lint charts/meu-chart/

# Erro de template
helm template test charts/meu-chart/ --debug

# Erro de instalação
helm install test charts/meu-chart/ --dry-run --debug

# Verificar valores
helm get values meu-release

# Verificar manifests
helm get manifest meu-release

# Logs da aplicação
kubectl logs -l app.kubernetes.io/name=meu-chart
```

### Debug Avançado
```bash
# Renderizar templates específicos
helm template test charts/meu-chart/ -s templates/deployment.yaml

# Validar com valores específicos
helm template test charts/meu-chart/ --set image.tag=latest --debug

# Verificar diferenças
helm diff upgrade meu-release charts/meu-chart/
```

## 📦 Publicação Rápida

### Processo Manual
```bash
# 1. Empacotar
helm package charts/meu-chart/ --destination .

# 2. Atualizar index
helm repo index . --url https://tech-preta.github.io/charts/

# 3. Commit e push
git add .
git commit -m "release: meu-chart v1.0.0"
git push origin main
```

### Processo Automático
```bash
# 1. Commit mudanças em charts/
git add charts/meu-chart/
git commit -m "feat: adiciona nova funcionalidade"
git push origin main

# 2. GitHub Actions automaticamente:
# - Testa o chart
# - Empacota
# - Atualiza GitHub Pages
```

## 🔗 Links Úteis

- [Helm Docs](https://helm.sh/docs/)
- [Best Practices](https://helm.sh/docs/chart_best_practices/)
- [Template Functions](https://helm.sh/docs/chart_template_guide/function_list/)
- [Chart Testing](https://github.com/helm/chart-testing)
- [Artifact Hub](https://artifacthub.io/)

---

💡 **Dica**: Salve esta página nos favoritos para consulta rápida!
