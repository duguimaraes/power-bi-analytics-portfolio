# 🚗 Dashboard de Inspeção de Trânsito
🇺🇸 Read in English: [README.md](./README.md)

## 🎯 Objetivo

Auxiliar a gestão de Segurança e Saúde Ocupacional (SSO), fornecendo visibilidade clara sobre os resultados das inspeções de trânsito, incluindo conformidade de condutores e veículos, taxas de não conformidade e itens críticos de segurança identificados durante as inspeções em campo.

---

## 🧰 Ferramentas & Tecnologias

* Power BI (Visualização de Dados & Dashboards)
* DAX (Medidas & KPIs)
* SQL (Extração & Transformação de Dados)
* Power Query (Limpeza & Modelagem de Dados)

---

## 📈 Principais Métricas

* Total de inspeções realizadas
* Taxa de conformidade vs não conformidade
* Percentual de inspeções totalmente conformes
* Distribuição das não conformidades por item de inspeção
* Detalhamento das inspeções de condutores e veículos
* Filtros por período, unidade e origem

---

## 🖼️ Prévia do Dashboard

![Overview](./images/overview.png)
![Overview](./images/overview.gif)

---

## 💡 Insights

* Proporciona visibilidade clara sobre os resultados das inspeções de trânsito realizadas pela área de Segurança e Saúde Ocupacional.
* Permite identificar rapidamente os itens com maior incidência de não conformidade, como habilitação, alerta de ré, rodagem/frenagem, uso de celular durante a condução, cinto de segurança e direção defensiva.
* Apoia ações preventivas ao destacar desvios recorrentes relacionados a condutores, veículos, unidades e origens.
* Melhora a rastreabilidade operacional ao consolidar registros detalhados das inspeções em uma única visão analítica.

---

## 📂 Dados & Consultas

Este projeto inclui a consulta SQL consolidada em `queries.sql`, responsável por:

* Dados de inspeção de condutores e veículos
* Classificação de conformidades e não conformidades por item de segurança
* Filtros das inspeções por período, unidade e origem
* Preparação dos dados operacionais para análise em dashboard

---

## 📊 Modelagem de Dados

Os dados foram estruturados e transformados no Power BI utilizando Power Query e DAX, garantindo análises eficientes e visualização clara dos resultados das inspeções e dos principais indicadores de segurança.

---

## ⚠️ Observações

* Todos os dados utilizados neste projeto foram anonimizados para fins de demonstração.
* Os indicadores de inspeção de segurança foram calculados no Power BI utilizando medidas DAX, enquanto o Power Query foi utilizado para limpeza e preparação dos dados de origem.

---

## 🚀 Impacto para o Negócio

Este dashboard permite:

* Melhor acompanhamento das inspeções de trânsito realizadas pela área de SSO
* Visibilidade clara dos níveis de conformidade e não conformidade
* Identificação mais rápida de desvios recorrentes de segurança
* Suporte a ações preventivas e melhorias na segurança operacional
* Maior rastreabilidade dos registros de inspeção de condutores e veículos
