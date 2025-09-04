# Giropops Senhas Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/techpreta)](https://artifacthub.io/packages/search?repo=techpreta)

Este é um Helm Chart para implantar a aplicação Giropops Senhas no Kubernetes, desenvolvida pela comunidade LINUXtips.

## 📋 Descrição

O Giropops Senhas é uma aplicação para geração de senhas seguras desenvolvida pela comunidade LINUXtips. Esta aplicação permite gerar senhas com diferentes níveis de complexidade e armazená-las de forma segura.

## 🎯 Ambientes Disponíveis

Este chart está disponível em três versões para diferentes ambientes:

- **dev/** - Ambiente de desenvolvimento
- **stg/** - Ambiente de staging/homologação
- **prd/** - Ambiente de produção

## ⚡ Pré-requisitos

- Kubernetes 1.19+
- Helm 3.0+
- Redis (para ambiente de produção)

## 🚀 Instalação

### Via Helm Repository

```bash
helm repo add techpreta https://tech-preta.github.io/charts/
helm repo update
```

### Instalação por ambiente

#### Desenvolvimento
```bash
helm install giropops-senhas-dev techpreta/giropops-senhas \
  -f charts/giropops-senhas/dev/values.yaml \
  --namespace development \
  --create-namespace
```

#### Staging
```bash
helm install giropops-senhas-stg techpreta/giropops-senhas \
  -f charts/giropops-senhas/stg/values.yaml \
  --namespace staging \
  --create-namespace
```

#### Produção
```bash
helm install giropops-senhas-prd techpreta/giropops-senhas \
  -f charts/giropops-senhas/prd/values.yaml \
  --namespace production \
  --create-namespace
```

## ⚙️ Configuração

### Parâmetros Comuns

| Parâmetro | Descrição | Padrão |
|-----------|-----------|---------|
| `image.repository` | Repositório da imagem | `linuxtips/giropops-senhas` |
| `image.tag` | Tag da imagem | `1.0.0` |
| `image.pullPolicy` | Política de pull da imagem | `IfNotPresent` |
| `replicaCount` | Número de réplicas | `1` |
| `service.type` | Tipo do serviço | `ClusterIP` |
| `service.port` | Porta do serviço | `5000` |

### Configurações por Ambiente

#### Desenvolvimento
- Redis não obrigatório (pode usar memória)
- Recursos limitados
- Sem persistência de dados

#### Staging
- Redis recomendado
- Recursos moderados
- Configurações similares à produção

#### Produção
- Redis obrigatório
- Alta disponibilidade
- Recursos adequados para produção
- Monitoramento habilitado
- Backup automático

## 🔧 Configurações Específicas de Produção

### Redis
```yaml
redis:
  enabled: true
  host: redis-service
  port: 6379
  password: "senha-secreta"
```

### Monitoramento
```yaml
monitoring:
  serviceMonitor:
    enabled: true
    namespace: monitoring
  podMonitor:
    enabled: true
```

### Persistência
```yaml
persistence:
  enabled: true
  storageClass: "fast-ssd"
  size: 10Gi
```

## 📊 Monitoramento

### Métricas disponíveis

- `giropops_senhas_generated_total` - Total de senhas geradas
- `giropops_senhas_requests_total` - Total de requisições
- `giropops_senhas_response_time_seconds` - Tempo de resposta

### Dashboards Grafana

Dashboards pré-configurados estão disponíveis para:
- Performance da aplicação
- Uso de recursos
- Métricas de negócio

## 🔍 Troubleshooting

### Verificar logs
```bash
kubectl logs -l app.kubernetes.io/name=giropops-senhas -n <namespace>
```

### Verificar conectividade com Redis
```bash
kubectl exec -it <pod-name> -n <namespace> -- redis-cli -h <redis-host> ping
```

### Verificar health check
```bash
kubectl get pods -l app.kubernetes.io/name=giropops-senhas -n <namespace>
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor, consulte o [guia de contribuição](../../../CONTRIBUTING.md) para mais detalhes.

## 📄 Licença

Este projeto é licenciado sob a GNU General Public License v3.0. Consulte o arquivo [LICENSE](../../../LICENSE) para mais detalhes.

---

Desenvolvido com ❤️ pela comunidade [LINUXtips](https://www.linuxtips.io/)
