# 📊 IT SLA Dashboard

## 🎯 Objective

Monitor and analyze IT service desk performance through SLA metrics, identifying operational bottlenecks, delays, and opportunities for process improvement.

---

## 🧰 Tools & Technologies

* Power BI (Data Visualization & Dashboarding)
* DAX (Measures & KPIs)
* SQL (Data Extraction & Transformation)
* Power Query (Data Cleaning & Modeling)

---

## 📈 Key Metrics

* Total number of tickets (open vs closed)
* Average resolution time
* SLA compliance rate
* Ticket distribution by category and priority
* Analyst performance (handling time and workload)

---

## 🖼️ Dashboard Preview

![Overview](./images/overview.png)

---

## 💡 Insights

* Higher resolution times were identified in specific service categories, indicating potential process inefficiencies.
* SLA breaches tend to occur during peak demand periods, suggesting the need for workload redistribution.
* Certain analysts show consistently higher workloads, highlighting opportunities for better task allocation.
* Tickets involving third-party dependencies significantly impact resolution time.

---

## 📂 Data & Queries

This project includes SQL queries organized in a single file (`queries.sql`), covering:

* Data extraction from workflow and service request tables
* Assignment tracking and runtime calculation
* Filtering of operational noise (automations, queues, and non-relevant tasks)
* Preparation of satisfaction survey data for analysis

---

## 📊 Data Modeling

* Data was modeled using a star-schema approach in Power BI
* Fact table: service tickets
* Dimensions: time, analyst, category, business unit

---

## ⚠️ Notes

* All data used in this project is **fictional or anonymized** for demonstration purposes.
* Satisfaction metrics were calculated in Power BI using DAX measures, while SQL was used to extract and prepare the source data.

---

## 🚀 Business Impact

This dashboard enables:

* Better visibility into IT support performance
* Faster identification of SLA risks
* Data-driven decision-making for resource allocation
* Continuous improvement of service processes
