# Helm Charts da Natalia Granato
Este repositório contém uma coleção de Helm Charts criados ou com contribuições de Natalia Granato para diferentes aplicações. Cada diretório neste repositório contém um Chart diferente.

## Como usar estes charts
Para usar estes charts, você precisa ter o Helm instalado em seu ambiente Kubernetes. Se você não tem o Helm instalado, siga as instruções na documentação oficial para instalá-lo.

Depois de instalar o Helm, adicione o repositório de charts da Natalia Granato com o seguinte comando:

```
helm repo add nataliagranato https://github.com/nataliagranato/charts
```
Você pode então pesquisar os charts disponíveis usando o comando helm search repo nataliagranato.

Para instalar um chart, use o comando helm install seguido pelo nome do chart que você deseja instalar e as opções necessárias. Por exemplo, para instalar o chart meu-chart, use o seguinte comando:

```
helm install meu-chart nataliagranato/meu-chart
```
Para obter mais informações sobre como usar o Helm, consulte a documentação oficial.

## Charts disponíveis
* [httpd](https://github.com/nataliagranato/nataliagranato-helm/tree/main/charts/httpd): uma calculadora que usa apache2.
* [rundeck-exporter](https://github.com/nataliagranato/helm-charts/tree/main/charts/rundeck-exporter): uma aplicação que coleta métricas do Rundeck e exporta para o Prometheus.
* [trudesk](https://github.com/nataliagranato/helm-charts/tree/main/charts/trudesk): o Trudesk é um software de serviço de help desk e gerenciamento de tickets de código aberto.
* [area-colaborador](https://github.com/nataliagranato/helm-charts/tree/main/charts/areacolaborador): um dashboard para acompanhar chamados, tickets e etc.
* [ocs](https://github.com/nataliagranato/helm-charts/tree/main/charts/ocs): é um software de código aberto projetado para ajudar as organizações a gerenciar ativos de TI.




## Contribuindo
Se você deseja contribuir para este repositório, por favor, faça um fork deste repositório, faça suas alterações e envie uma pull request. As contribuições são sempre bem-vindas!
