# Security Policy

## 🔒 Versões Suportadas

| Versão | Suportada |
| ------- | --------- |
| main branch | ✅ |
| Released charts | ✅ |
| Development branches | ❌ |

## 🚨 Reportar uma Vulnerabilidade

A segurança é uma prioridade para nós. Se você descobrir uma vulnerabilidade de segurança, por favor, siga estas diretrizes:

### 📧 Contato

- **Email**: contato@nataliagranato.xyz
- **Assunto**: [SECURITY] Vulnerabilidade em Helm Chart

### 📝 Informações Necessárias

Inclua as seguintes informações em seu relatório:

1. **Chart Afetado**: Nome e versão do chart
2. **Descrição**: Descrição detalhada da vulnerabilidade
3. **Impacto**: Avaliação do impacto potencial
4. **Reprodução**: Passos para reproduzir a vulnerabilidade
5. **Sugestão**: Sugestão de correção (se houver)

### ⏱️ Processo de Resposta

1. **Confirmação**: Confirmaremos o recebimento em 24 horas
2. **Avaliação**: Avaliaremos a vulnerabilidade em 72 horas
3. **Correção**: Trabalharemos em uma correção prioritária
4. **Divulgação**: Coordenaremos a divulgação responsável

### 🛡️ Diretrizes de Segurança

#### Para Usuários:
- Mantenha seus charts atualizados
- Use imagens oficiais sempre que possível
- Configure SecurityContext apropriadamente
- Implemente Network Policies quando necessário
- Monitore vulnerabilidades conhecidas

#### Para Contribuidores:
- Não inclua secrets em values.yaml
- Use imagePullPolicy: IfNotPresent ou Always
- Configure probes de saúde
- Documente requisitos de segurança
- Teste com scanner de vulnerabilidades

### 🏆 Reconhecimento

Agradecemos pesquisadores de segurança responsáveis. Com sua permissão, reconheceremos sua contribuição publicamente após a correção.

### 📚 Recursos Adicionais

- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)
- [Helm Security Considerations](https://helm.sh/docs/topics/provenance/)
- [OWASP Kubernetes Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Kubernetes_Security_Cheat_Sheet.html)

---

Obrigada por ajudar a manter nossos charts seguros! 🔒
