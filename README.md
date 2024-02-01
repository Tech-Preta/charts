- # Natalia Granato's Helm Charts Collection

Este repositório abriga uma coleção de Helm Charts criados ou com contribuições de Natalia Granato para diversas aplicações. Helm Charts são uma maneira eficaz de definir, instalar e atualizar até mesmo as aplicações mais complexas no Kubernetes.

## Como usar os Helm Charts 
1. Certifique-se de ter o Helm instalado. Se ainda não tiver, siga as [instruções de instalação do Helm](https://helm.sh/docs/intro/install/) . 
2. Faça o clone do repositório:

```bash
git clone https://github.com/Tech-Preta/charts.git
``` 

3. Navegue pelo repositório para encontrar o Helm Chart desejado. 
4. Instale o Helm Chart usando o comando `helm install`:

```bash
helm install nome-da-release -n nome-da-namespace . # O ponto ao final indica que você está no diretório do chart que será instalado
```

5. Personalize a instalação conforme necessário, passando valores adicionais via values.yaml ou flags de linha de comando.

## Charts disponíveis
* [httpd](https://github.com/Tech-Preta/charts/tree/main/charts/httpd): uma calculadora que usa apache2.
* [rundeck-exporter](https://github.com/Tech-Preta/charts/tree/main/charts/rundeck-exporter): uma aplicação que coleta métricas do Rundeck e exporta para o Prometheus.
* [trudesk](https://github.com/Tech-Preta/charts/tree/main/charts/trudesk): o Trudesk é um software de serviço de help desk e gerenciamento de tickets de código aberto.
* [area-colaborador](https://github.com/Tech-Preta/charts/tree/main/charts/areacolaborador): um dashboard para acompanhar chamados, tickets e etc.
* [ocs](https://github.com/Tech-Preta/charts/tree/main/charts/ocs): é um software de código aberto projetado para ajudar as organizações a gerenciar ativos de TI.
* [rundeck](https://github.com/Tech-Preta/charts/tree/main/charts/rundeck): é uma plataforma de automação de operações de TI (Ops) de código aberto.

...
## Contribuições

Contribuições são bem-vindas! Se você tiver melhorias, correções ou novos Helm Charts para adicionar, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

## Licença

Este projeto é licenciado sob a [GNU General Public License v3.0](https://github.com/Tech-Preta/charts/blob/gh-pages/LICENSE) . Consulte o arquivo `LICENSE` para obter mais detalhes.---
