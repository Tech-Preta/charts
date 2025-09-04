# Rundeck Exporter Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/techpreta)](https://artifacthub.io/packages/search?repo=techpreta)

Este é um Helm Chart para implantar o Rundeck Exporter no Kubernetes, desenvolvido por Phillipe Smith como parte da contribuição da comunidade do Rundeck.

## 📋 Descrição

O Rundeck Exporter é uma ferramenta que coleta métricas e informações do Rundeck para fins de monitoramento e observabilidade utilizando o Prometheus e o Grafana para exibição de dados de forma amigável.

## ⚡ Pré-requisitos

- Kubernetes 1.19+
- Helm 3.0+
- Rundeck em funcionamento
- Prometheus (opcional, para coleta de métricas)
- Grafana (opcional, para visualização)

## 🚀 Instalação

### Via Helm Repository

```bash
helm repo add techpreta https://tech-preta.github.io/charts/
helm repo update
helm install rundeck-exporter techpreta/rundeck-exporter
```

### Via Git Clone

## ⚙️ Configuração

| Parâmetro | Descrição | Padrão |
|-----------|-----------|---------|
| `image.repository` | Repositório da imagem do Rundeck Exporter | `phsmith/rundeck-exporter` |
| `image.tag` | Tag da imagem | `2.6.1` |
| `image.pullPolicy` | Política de pull da imagem | `IfNotPresent` |
| `replicaCount` | Número de réplicas | `1` |
| `service.type` | Tipo do serviço | `ClusterIP` |
| `service.port` | Porta do serviço | `9620` |
| `env.RUNDECK_TOKEN` | Token de acesso do Rundeck | `your-rundeck-token` |
| `env.RUNDECK_URL` | URL do servidor Rundeck | `your-rundeck-url` |
| `env.RUNDECK_USERNAME` | Usuário do Rundeck | `your-rundeck-username` |
| `env.RUNDECK_USERPASSWORD` | Senha do usuário Rundeck | `your-rundeck-password` |
| `env.RUNDECK_API_VERSION` | Versão da API do Rundeck | `40` |
| `env.RUNDECK_SKIP_SSL` | Pular verificação SSL | `true` |
| `ingress.enabled` | Habilitar ingress | `false` |
| `resources.limits.cpu` | Limite de CPU | `100m` |
| `resources.limits.memory` | Limite de memória | `128Mi` |

### Exemplo de personalização

```bash
helm install rundeck-exporter techpreta/rundeck-exporter \
  --set env.RUNDECK_URL=https://meu-rundeck.exemplo.com \
  --set env.RUNDECK_TOKEN=meu-token-secreto \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=rundeck-exporter.exemplo.com
```

## 📊 Monitoramento

### Métricas disponíveis

O Rundeck Exporter expõe as seguintes métricas:

- `rundeck_project_executions_total` - Total de execuções por projeto
- `rundeck_project_execution_duration_seconds` - Duração das execuções
- `rundeck_system_stats_cpu_load_average` - Carga média da CPU
- `rundeck_system_stats_memory_total` - Memória total do sistema
- `rundeck_system_stats_memory_free` - Memória livre do sistema

### Configuração do ServiceMonitor

Se você estiver usando o Prometheus Operator, pode habilitar o ServiceMonitor:

```yaml
serviceMonitor:
  enabled: true
  namespace: monitoring
  labels:
    app: prometheus
```

## 🔧 Solução de problemas

### Verificar logs

```bash
kubectl logs -l app.kubernetes.io/name=rundeck-exporter
```

### Verificar conectividade com Rundeck

```bash
kubectl exec -it <pod-name> -- curl -k $RUNDECK_URL/api/40/system/info
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor, consulte o [guia de contribuição](../../CONTRIBUTING.md) para mais detalhes.

## 📄 Licença

Este projeto é licenciado sob a GNU General Public License v3.0. Consulte o arquivo [LICENSE](../../LICENSE) para mais detalhes.
'service.port': A porta em que o Rundeck Exporter expõe as métricas.
'env': Variáveis de ambiente para configurar o Rundeck Exporter.

Consulte o arquivo values.yaml para ver todas as opções de configuração disponíveis.

## Personalização
Você pode personalizar ainda mais a implantação do Rundeck Exporter editando o arquivo deployment.yaml no diretório templates. Aqui você pode adicionar volumes, definir recursos, configurar sondas de prontidão e vitalidade, entre outras opções.

## Remoção
Para remover o Rundeck Exporter, execute o seguinte comando:

```
helm uninstall meu-rundeck-exporter

```
Isso removerá todos os recursos relacionados ao Rundeck Exporter do cluster Kubernetes.
