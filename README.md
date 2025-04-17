# Apache Kafka 4.0.0 - KRaft Mode Cluster Setup with Real-world Use Case (Annuity Insurance)

## 📦 Overview
Apache Kafka 4.0.0 is a distributed streaming platform used to build real-time data pipelines and streaming applications. It removes the dependency on ZooKeeper by using KRaft (Kafka Raft) mode for metadata management.

This document outlines:
- How to build a multi-broker Kafka 4.0.0 cluster
- Set up performance testing
- Monitor using Prometheus & Grafana
- Real-world use case in Annuity Insurance

- This repository provides a production-ready Kafka 4.0.0 (KRaft mode) multi-broker setup with real-world use cases tailored for the annuity insurance domain. It includes setup automation scripts, performance testing utilities, and monitoring integration with Prometheus and Grafana. The use case demonstrates how Kafka’s partitions, brokers, replication, and consumer groups work together to streamline real-time event processing for high-volume, fault-tolerant workloads such as policy events, fund allocations, and compliance tracking.
...

##☁️ Related AWS Services

Technology	AWS Equivalent	When to Use
Apache Kafka	Amazon MSK (Managed Streaming for Apache Kafka)	High-throughput, real-time data pipelines and streaming apps
Apache ActiveMQ	Amazon MQ	JMS-compatible message queuing for legacy or enterprise apps
✅ Amazon MSK (Managed Kafka)
Fully-managed Kafka, compatible with open-source Kafka 4.0.0+

Handles provisioning, patching, and scaling

Integrated with IAM, CloudWatch, VPC

📘 Use Case: Stream annuity events from customer portals, trigger real-time dashboards and fraud alerts.

✅ Amazon MQ (Managed ActiveMQ/Artemis)
Ideal for JMS-based applications (e.g., Java EE, Spring apps)

Supports queues and topics with guaranteed delivery

Seamless lift-and-shift from on-prem brokers

📘 Use Case: Bridge communications between legacy claims management system and internal finance apps.


## 📬 Contact
For enterprise Kafka setup in insurance or FinTech, contact: `biju.tholath@outlook.com`
