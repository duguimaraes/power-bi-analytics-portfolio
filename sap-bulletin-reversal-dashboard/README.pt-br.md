# 📊 Painel de Controle de Estornos do Boletim
🇺🇸 English version: [README.md](./README.md)

## 🎯 Objetivo

Apoiar a visibilidade da gestão sobre as transações de estorno, permitindo um melhor controle das inconsistências operacionais, a identificação de erros recorrentes e o monitoramento do comportamento de estorno em todas as unidades de negócio.

---

## 🧰 Ferramentas e Tecnologias

* Power BI (Visualização de Dados e Painéis)
* SQL (Extração e Consolidação de Dados)
* Power Query (Transformação de Dados)
* DAX (Métricas e Agregações)

---

## 📈 Métricas Principais

* Número total de transações de estorno
* Estornos por unidade de negócio (fazenda/operação)
* Estornos por tipo de boletim (Combustível, Plantio, Suprimentos, etc.)
* Tendência histórica de estornos ao longo do tempo
* Distribuição de estornos por categoria operacional

---

## 🖼️ Pré-visualização do Painel

![Overview](./images/overview.png)

---

## 💡 Insights

* Oferece um forte suporte para apresentações gerenciais, proporcionando uma visão clara da atividade de estorno em todas as operações.

* Permite identificar as unidades de negócio com o maior volume de estornos, destacando potenciais problemas nos processos.

* Ajuda a detectar padrões recorrentes de erros operacionais por meio da análise de tendências históricas.

* Suporta a análise de quais tipos de operações (por exemplo, combustível, plantio, suprimentos) são mais impactados por estornos.

* Facilita o monitoramento da consistência dos dados e da confiabilidade operacional em diferentes unidades.

---

## 📂 Dados e Consultas

Este projeto inclui consultas SQL consolidadas em `queries.sql`, responsáveis ​​por:

* Extrair registros relacionados a estornos de múltiplas unidades de negócio
* Padronizar dados em diferentes esquemas de ERP
* Classificar tipos de boletins em categorias unificadas
* Consolidar todas as fontes em um único conjunto de dados analíticos

---

## 📊 Modelagem de Dados

Os dados foram transformados e estruturados no Power BI usando Power Query e DAX, garantindo categorização consistente e desempenho analítico eficiente.

---

## ⚠️ Observações

* Todos os dados utilizados neste projeto são **anonimizados e ligeiramente ajustados** para preservar a confidencialidade.

* A estrutura e a lógica analíticas refletem cenários operacionais reais.

---

## 🚀 Impacto nos Negócios

Este painel permite:

* Suporte para apresentações gerenciais com insights operacionais claros
* Melhor controle e monitoramento de transações de estorno
* Identificação de erros operacionais recorrentes
* Maior visibilidade das inconsistências de processos entre as unidades de negócios
* Ações baseadas em dados para reduzir retrabalho e melhorar a precisão operacional
