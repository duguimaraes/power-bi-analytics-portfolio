# 📊 Painel de Paradas Operacionais – Máquina Busa
🇺🇸 English version: [README.md](./README.md)

## 🎯 Objetivo

Apoiar a gestão com uma visão clara das paradas operacionais da máquina Busa, permitindo monitorar o desempenho do equipamento, identificar falhas recorrentes e analisar o impacto das paradas no processo de beneficiamento de algodão.

---

## 🧰 Ferramentas & Tecnologias

* Power BI (Visualização de Dados)
* DAX (Métricas e Indicadores)
* SQL (Extração e Transformação de Dados)
* Power Query (Tratamento de Dados)

---

## 📈 Principais Métricas

* Tempo total de parada (minutos)
* Tempo efetivo parado (considerando percentual de impacto)
* Paradas por componente
* Paradas por causa
* Paradas por motivo operacional
* Distribuição por turno e sessão
* Paradas por unidade operacional

---

## 🖼️ Visualização do Dashboard

![Visão Geral](./images/overview.gif)

---

## 💡 Insights

* Apoia apresentações gerenciais com uma visão clara das paradas operacionais e desempenho do equipamento.
* Permite identificar componentes com maior impacto nas paradas, auxiliando na priorização de manutenção.
* Evidencia as principais causas das paradas, permitindo ações direcionadas para redução de falhas.
* Possibilita análise dos motivos operacionais, diferenciando paradas planejadas e não planejadas.
* Ajuda a entender o comportamento das paradas ao longo dos turnos, melhorando o planejamento operacional.

---

## 📂 Dados & Consultas

O projeto inclui consultas SQL organizadas no arquivo `queries.sql`, responsáveis por:

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
