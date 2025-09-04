# 📚 Documentação - Tech-Preta Charts

Bem-vindo à documentação completa dos Helm Charts do repositório Tech-Preta/charts!

## 📋 Documentos Disponíveis

### 🚀 Guias Principais

| Documento | Descrição | Público-Alvo |
|-----------|-----------|--------------|
| [**Guia de Publicação**](./helm-publishing-guide.md) | Processo completo para criação e publicação de charts | Desenvolvedores e Contribuidores |
| [**Guia de Versionamento**](./versioning-guide.md) | Estratégias e práticas de versionamento | Mantenedores e Contribuidores |
| [**Melhores Práticas**](./best-practices.md) | Padrões e práticas recomendadas | Todos os Contribuidores |

### 📖 Conteúdo por Categoria

#### 🎯 Para Iniciantes
- **[Guia de Publicação - Pré-requisitos](./helm-publishing-guide.md#-pré-requisitos)**
  - Ferramentas necessárias
  - Configuração do ambiente
  - Primeiros passos

- **[Estrutura do Projeto](./helm-publishing-guide.md#-estrutura-do-projeto)**
  - Organização de diretórios
  - Arquivos essenciais
  - Convenções adotadas

#### 🔧 Para Desenvolvedores
- **[Criação de Charts](./helm-publishing-guide.md#-criação-de-charts)**
  - Templates básicos
  - Configuração de values
  - Estrutura recomendada

- **[Melhores Práticas - Estrutura](./best-practices.md#-estrutura-de-charts)**
  - Templates essenciais
  - Helpers reutilizáveis
  - Organização de código

#### 🚀 Para Mantenedores
- **[Empacotamento](./helm-publishing-guide.md#-empacotamento)**
  - Geração de packages
  - Validação de charts
  - Atualização do índice

- **[Versionamento](./versioning-guide.md#-semantic-versioning)**
  - Semantic Versioning
  - Estratégias por ambiente
  - Processo de release

#### 🔒 Segurança
- **[Práticas de Segurança](./best-practices.md#-segurança)**
  - SecurityContext
  - Gerenciamento de Secrets
  - RBAC e Network Policies

#### 🤖 Automação
- **[CI/CD Automático](./helm-publishing-guide.md#-cicd-automático)**
  - GitHub Actions
  - Workflows de teste
  - Release automático

## 🎯 Fluxos de Trabalho

### Para Criar um Novo Chart

1. 📖 Leia o [Guia de Publicação](./helm-publishing-guide.md#-criação-de-charts)
2. 🏗️ Use a [estrutura recomendada](./best-practices.md#-estrutura-de-charts)
3. 🔒 Implemente [práticas de segurança](./best-practices.md#-segurança)
4. 🧪 Adicione [testes apropriados](./best-practices.md#-testes)
5. 📝 Documente seguindo os [padrões](./best-practices.md#-documentação)

### Para Atualizar um Chart Existente

1. 🏷️ Defina a [estratégia de versão](./versioning-guide.md#-semantic-versioning)
2. 🔄 Siga o [processo de release](./versioning-guide.md#-processo-de-release)
3. 📦 Execute o [empacotamento](./helm-publishing-guide.md#-empacotamento)
4. 🚀 Use a [publicação automática](./helm-publishing-guide.md#-publicação)

### Para Resolver Problemas

1. 🔍 Consulte o [Troubleshooting](./helm-publishing-guide.md#-troubleshooting)
2. 🧪 Execute os [comandos de debug](./helm-publishing-guide.md#comandos-de-debug)
3. 📋 Use o [checklist de qualidade](./best-practices.md#-checklist-de-qualidade)

## 📊 Charts Disponíveis

| Chart | Versão | Documentação | Status |
|-------|---------|--------------|---------|
| [giropops-senhas-dev](../charts/giropops-senhas/) | 0.1.0 | [README](../charts/giropops-senhas/README.md) | ✅ Ativo |
| [giropops-senhas-stg](../charts/giropops-senhas/) | 0.1.0 | [README](../charts/giropops-senhas/README.md) | ✅ Ativo |
| [giropops-senhas-prd](../charts/giropops-senhas/) | 0.1.0 | [README](../charts/giropops-senhas/README.md) | ✅ Ativo |
| [rundeck-exporter](../charts/rundeck-exporter/) | 0.1.8 | [README](../charts/rundeck-exporter/README.md) | ✅ Ativo |
| [super-mario](../charts/super-mario/) | 0.1.0 | - | ✅ Ativo |
| [trudesk](../charts/trudesk/) | 1.0.0 | - | ✅ Ativo |

## 🛠️ Ferramentas e Recursos

### Comandos Úteis

```bash
# Validação
helm lint charts/meu-chart/
helm template test charts/meu-chart/ --debug

# Empacotamento
helm package charts/meu-chart/ --destination .
helm repo index . --url https://tech-preta.github.io/charts/

# Testes
helm install test charts/meu-chart/ --dry-run
helm test meu-release
```

### Links Externos

- 📖 [Documentação Oficial do Helm](https://helm.sh/docs/)
- 🏆 [Chart Best Practices](https://helm.sh/docs/chart_best_practices/)
- 🧪 [Chart Testing](https://github.com/helm/chart-testing)
- 🚀 [Chart Releaser](https://github.com/helm/chart-releaser)
- 🏪 [Artifact Hub](https://artifacthub.io/)

### Templates e Exemplos

- 📄 [Template de Chart.yaml](./helm-publishing-guide.md#2-configurar-chartyaml)
- ⚙️ [Template de values.yaml](./helm-publishing-guide.md#3-configurar-valuesyaml)
- 📝 [Template de README.md](./best-practices.md#readmemd-template)
- 🧪 [Templates de Testes](./best-practices.md#testes-de-conexão)

## 🤝 Contribuindo

### Como Contribuir

1. 📖 Leia o [CONTRIBUTING.md](../CONTRIBUTING.md)
2. 🍴 Faça um fork do repositório
3. 🌟 Crie uma branch para sua feature
4. 📝 Siga as práticas documentadas aqui
5. 🔄 Abra um Pull Request

### Obtendo Ajuda

- 📧 [Abra uma issue](https://github.com/Tech-Preta/charts/issues/new)
- 💬 [Inicie uma discussão](https://github.com/Tech-Preta/charts/discussions)
- 📖 [Consulte a wiki](https://github.com/Tech-Preta/charts/wiki)

## 📅 Changelog da Documentação

| Data | Mudança | Autor |
|------|---------|-------|
| 2025-09-04 | Criação inicial da documentação completa | @nataliagranato |
| 2025-09-04 | Adição de guias de versionamento e melhores práticas | @nataliagranato |

---

## 📄 Licença

Esta documentação é licenciada sob a [GNU General Public License v3.0](../LICENSE).

---

Desenvolvido com ❤️ pela [Tech-Preta](https://github.com/Tech-Preta)
