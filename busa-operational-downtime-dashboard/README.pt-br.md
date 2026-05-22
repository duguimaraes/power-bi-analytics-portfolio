# 📊 Painel de Paradas Operacionais – Máquina Busa
🇺🇸 English version: [README.md](./README.md)

## 🎯 Objetivo

Apoiar a gestão e a visibilidade dos eventos de tempo de inatividade operacional na máquina Busa, permitindo um melhor monitoramento do desempenho do equipamento, a identificação de falhas recorrentes e a análise do impacto do tempo de inatividade na operação de processamento de algodão.

---

## 🧰 Ferramentas & Tecnologias

* Power BI (Visualização de Dados)
* DAX (Medidas e KPIs)
* SQL (Extração e Transformação de Dados)
* Power Query (Limpeza e Modelagem de Dados)

---

## 📈 Principais Métricas

* Tempo total de inatividade (horas e minutos)
* Tempo de inatividade efetivo da sessão (considerando a porcentagem de impacto)
* Porcentagem de eficiência da sessão
* Tempo de inatividade por componente
* Tempo de inatividade por motivo operacional
* Distribuição do tempo de inatividade por turno e sessão
* Tempo de inatividade por unidade de negócios (instalação)

---

## 🖼️ Visualização do Dashboard

![Visão Geral](./images/overview.gif)

---

## 💡 Insights

* Oferece forte suporte para apresentações gerenciais, proporcionando visibilidade clara do tempo de inatividade operacional e do desempenho dos equipamentos
* Permite a identificação dos componentes com maior impacto no tempo de inatividade, auxiliando na priorização da manutenção.
* Destaca as principais causas de tempo de inatividade, permitindo ações direcionadas para reduzir falhas.
* Auxilia na análise de motivos operacionais, ajudando a distinguir entre paradas planejadas e não planejadas.
* Permite o monitoramento do comportamento do tempo de inatividade ao longo dos turnos, melhorando o planejamento operacional e a eficiência.

---

## 📂 Dados & Consultas

O projeto inclui a consulta SQL no arquivo `queries.sql`, responsável por:

* Extração dos eventos de parada
* Mapeamento de componentes, causas e motivos
* Cálculo do tempo total e tempo efetivo de parada
* Estruturação de sessões, turnos e unidades para análise

---

## 📊 Modelagem de Dados

Os dados foram estruturados no Power BI utilizando uma abordagem dimensional, separando componentes, causas e motivos para permitir análises em múltiplos níveis.

---

## ⚠️ Observações

* Todos os dados foram **anonimizados** para fins de portfólio.
* Os valores foram ajustados mantendo a lógica real de análise.

---

## 🚀 Impacto no Negócio

Este dashboard permite:

* Apoio à tomada de decisão gerencial
* Melhor controle das paradas operacionais
* Identificação de falhas recorrentes
* Visibilidade sobre ineficiências operacionais
* Ações orientadas por dados para redução de downtime e melhoria do processo
