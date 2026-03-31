# 📊 Painel de SLA de TI
🇺🇸 English version: [README.md](./README.md)

## 🎯 Objetivo

Auxiliar as apresentações da gerência, fornecendo visibilidade clara do desempenho dos serviços de TI, incluindo chamados em aberto, tempo médio de resolução e distribuição da carga de trabalho.

---

## 🧰 Ferramentas e Tecnologias

* Power BI (Visualização de Dados e Dashboards)
* DAX (Medidas e KPIs)
* SQL (Extração e Transformação de Dados)
* Power Query (Limpeza e Modelagem de Dados)

---

## 📈 Métricas Principais

* Número total de chamados (abertos vs. fechados)
* Tempo médio de resolução
* Taxa de conformidade com o SLA
* Distribuição de chamados por categoria, sistema e prioridade
* Desempenho do analista (tempo de atendimento e carga de trabalho)

---

## 🖼️ Pré-visualização do Dashboard

![Overview](./images/overview.png)
![Overview](./images/overview2.png)

---

## 💡 Insights

* Oferece suporte robusto para apresentações gerenciais, proporcionando uma visão clara do desempenho dos serviços de TI e da distribuição da carga de trabalho.

* Permite a identificação rápida de chamados com longos tempos de resolução, ajudando a priorizar casos críticos.

* Auxilia na tomada de decisões para a realocação de chamados entre analistas, melhorando a eficiência geral e o cumprimento dos SLAs.

* Chamados que envolvem dependências de terceiros impactam significativamente o tempo de resolução.

---

## 📂 Dados e Consultas

Este projeto inclui consultas SQL organizadas em um único arquivo (`queries.sql`), abrangendo:

* Extração de dados de tabelas de fluxo de trabalho e solicitações de serviço
* Rastreamento de atribuições e cálculo de tempo de execução
* Filtragem de ruído operacional (automações, filas e tarefas irrelevantes)
* Preparação de dados de pesquisa de satisfação para análise

---

## 📊 Modelagem de Dados
Os dados foram estruturados e transformados no Power BI usando Power Query e DAX, garantindo uma análise eficiente e uma visualização clara das principais métricas.

---

## ⚠️ Observações

* Todos os dados usados ​​neste projeto são **fictícios ou anonimizados** para fins de demonstração.

* As métricas de satisfação foram calculadas no Power BI usando medidas DAX, enquanto o SQL foi usado para extrair e preparar os dados de origem.

---

## 🚀 Impacto nos Negócios

Este painel permite:

* Suporte para apresentações gerenciais com dados de serviços de TI claros e estruturados
* Melhor controle e monitoramento de chamados em aberto
* Visibilidade clara do tempo médio de resolução e do desempenho de execução
* Melhor rastreamento da distribuição da carga de trabalho entre os analistas
* Identificação mais rápida de chamados com longos tempos de resolução, permitindo priorização e realocação
