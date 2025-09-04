# Guia de Contribuição

Obrigada por seu interesse em contribuir com este projeto! 🎉

## 📋 Antes de Começar

1. Certifique-se de ter o [Helm](https://helm.sh/docs/intro/install/) instalado
2. Tenha um cluster Kubernetes para testes (pode ser [kind](https://kind.sigs.k8s.io/), [minikube](https://minikube.sigs.k8s.io/), etc.)
3. Familiarize-se com as [melhores práticas do Helm](https://helm.sh/docs/chart_best_practices/)

## 🚀 Como Contribuir

### 1. Fork e Clone

```bash
# Fork o repositório no GitHub
# Clone seu fork
git clone https://github.com/SEU_USUARIO/charts.git
cd charts
```

### 2. Crie uma Branch

```bash
git checkout -b feature/nova-funcionalidade
# ou
git checkout -b fix/correcao-bug
```

### 3. Faça suas Alterações

#### Para Novos Charts:
- Crie um diretório em `charts/`
- Inclua `Chart.yaml`, `values.yaml`, e templates
- Adicione um `README.md` detalhado
- Inclua testes em `templates/tests/`

#### Para Charts Existentes:
- Mantenha compatibilidade com versões anteriores
- Aumente a versão do chart se necessário
- Atualize a documentação

### 4. Teste Localmente

```bash
# Lint do chart
helm lint charts/SEU_CHART/

# Teste de instalação
helm install test-release charts/SEU_CHART/ --dry-run --debug

# Teste em cluster local
helm install test-release charts/SEU_CHART/
```

### 5. Execute os Testes CI

```bash
# Instale chart-testing
pip install yamllint
pip install yamale

# Execute os mesmos testes do CI
ct lint --target-branch main
ct install --target-branch main
```

### 6. Commit e Push

```bash
git add .
git commit -m "feat: adiciona novo chart para aplicacao-exemplo"
git push origin feature/nova-funcionalidade
```

### 7. Abra um Pull Request

- Use um título descritivo
- Inclua detalhes sobre as mudanças
- Referencie issues relacionadas

## 📝 Padrões de Commits

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` para novas funcionalidades
- `fix:` para correções de bugs
- `docs:` para mudanças na documentação
- `test:` para adição/modificação de testes
- `refactor:` para refatoração de código
- `chore:` para tarefas de manutenção

## 🎯 Diretrizes para Charts

### Estrutura Mínima
```
charts/meu-chart/
├── Chart.yaml
├── README.md
├── values.yaml
└── templates/
    ├── _helpers.tpl
    ├── deployment.yaml
    ├── service.yaml
    ├── serviceaccount.yaml
    ├── NOTES.txt
    └── tests/
        └── test-connection.yaml
```

### Chart.yaml
```yaml
apiVersion: v2
name: meu-chart
description: Descrição do meu chart
version: 0.1.0
appVersion: "1.0.0"
keywords:
  - palavra-chave
maintainers:
  - name: Seu Nome
    email: seu@email.com
home: https://github.com/Tech-Preta/charts
sources:
  - https://github.com/projeto/fonte
```

### values.yaml
- Use valores sensatos como padrão
- Comente configurações importantes
- Organize logicamente as seções

### Templates
- Use `_helpers.tpl` para funções comuns
- Inclua labels e annotations padrão
- Adicione probes de saúde quando aplicável
- Configure recursos e limites

### README.md
Inclua:
- Descrição do chart
- Pré-requisitos
- Instruções de instalação
- Tabela de configuração
- Exemplos de uso
- Troubleshooting

## 🧪 Testes

### Testes Obrigatórios
- Lint com `helm lint`
- Instalação com `helm install --dry-run`
- Teste de conexão em `templates/tests/`

### Testes Recomendados
- Teste em múltiplos valores
- Teste de upgrade
- Teste de rollback

## 📊 Review Process

1. **Automated Checks**: CI deve passar
2. **Manual Review**: Revisor verificará:
   - Qualidade do código
   - Documentação
   - Testes
   - Segurança
3. **Testing**: Teste manual quando necessário

## 🔒 Segurança

- Não inclua secrets em values.yaml
- Use imagePullPolicy apropriada
- Configure SecurityContext quando necessário
- Documente requisitos de segurança

## 💡 Dicas

- Mantenha charts simples e focados
- Reutilize helpers comuns
- Documente decisões não óbvias
- Teste em diferentes cenários
- Seja consistente com charts existentes

## 🆘 Precisa de Ajuda?

- 📧 [Abra uma issue](https://github.com/Tech-Preta/charts/issues/new)
- 💬 [Inicie uma discussão](https://github.com/Tech-Preta/charts/discussions)
- 📖 [Consulte a wiki](https://github.com/Tech-Preta/charts/wiki)

## 📄 Licença

Ao contribuir, você concorda que suas contribuições serão licenciadas sob a GNU General Public License v3.0.

---

Obrigada por contribuir! ❤️
