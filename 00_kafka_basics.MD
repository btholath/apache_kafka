# Apache Kafka 4.0.0 - KRaft Mode Cluster Setup with Real-world Use Case (Annuity Insurance)

## 📦 Overview
Apache Kafka 4.0.0 is a distributed streaming platform used to build real-time data pipelines and streaming applications. It removes the dependency on ZooKeeper by using KRaft (Kafka Raft) mode for metadata management.

This document outlines:
- How to build a multi-broker Kafka 4.0.0 cluster
- Set up performance testing
- Monitor using Prometheus & Grafana
- Real-world use case in Annuity Insurance

---

## 🚀 Kafka in Annuity Insurance: Real-World Scenario

### Scenario:
An Annuity Insurance platform handles high-volume events such as:
- Customer onboarding
- Premium payments
- Interest accruals
- Fund reallocations
- Maturity or surrender notifications

### Kafka Setup:
| Component            | Purpose                                                             |
|---------------------|---------------------------------------------------------------------|
| **Topic**           | `annuity-events`                                                    |
| **Partitions**      | 10 (parallel processing by customer ID)                             |
| **Brokers**         | 3 nodes (distributes partitions, handles scale)                     |
| **Replication**     | 3 (ensures fault tolerance and zero data loss)                      |
| **Consumer Groups** | Separate systems (DB, Analytics, Alerts) consume data independently |

---

## 🧠 Layman Explanation of Key Concepts

### ✅ Partitions
Break topic data into lanes. More lanes = higher throughput. E.g., policy events per customer.

### ✅ Brokers
Each Kafka broker handles a portion of partitions. Brokers form the cluster. Think: distributed team members.

### ✅ Replication
Each partition is duplicated across brokers. So if one broker crashes, no data is lost.

### ✅ Consumer Groups
Groups of services that process data. Each group gets its own copy of the stream.

---

## 🖼️ How It All Connects
```
Web Portal/Agents → Kafka Producers → [annuity-events topic]
                                           ↓
                          Partitions split across brokers (1, 2, 3)
                                           ↓
    ┌────────────────────┬──────────────────────┬─────────────────────┐
    │ policy-admin-group │ analytics-group      │ compliance-group    │
    │ → updates DB       │ → dashboards in BI   │ → alerts & audit    │
    └────────────────────┴──────────────────────┴─────────────────────┘
```

---

## 🔧 Performance Test Scripts

### Producer Performance
```bash
bin/kafka-producer-perf-test.sh \
--topic perf \
--num-records 10000 \
--throughput 1000 \
--record-size 1000 \
--producer-props bootstrap.servers=localhost:9092 \
| tee producer_perf_results.csv
```

### Consumer Performance
```bash
bin/kafka-consumer-perf-test.sh \
--broker-list localhost:9092 \
--topic perf \
--messages 10000 \
| tee consumer_perf_results.csv
```

---

## 📈 Monitoring with Prometheus + Grafana

### JMX Exporter Config (`kafka-2_0_0.yml`)
```yaml
startDelaySeconds: 0
lowercaseOutputName: true
whitelistObjectNames:
  - kafka.server:type=BrokerTopicMetrics,name=*
  - java.lang:type=Memory
  - java.lang:type=GarbageCollector,name=*
```

### Prometheus Scrape Config
```yaml
scrape_configs:
  - job_name: 'kafka'
    static_configs:
      - targets: ['localhost:7071']
```

### Pipeline Summary
```
Kafka JVM (JMX) → JMX Exporter → Prometheus → Grafana
```

---

## 📁 Downloadable Assets
- `start-all-brokers.sh` – Starts the full Kafka KRaft cluster
- `run-producer-perf-test.sh` – Simulates high-throughput producer
- `run-consumer-perf-test.sh` – Measures consumer latency
- `kafka-2_0_0.yml` – JMX Exporter config for metrics
- `prometheus.yml` – Scraping config for Prometheus
- Dashboards – Grafana JSON for Kafka broker metrics

---

## 📬 Contact
For enterprise Kafka setup in insurance or FinTech, contact: `biju.tholath@outlook.com`


