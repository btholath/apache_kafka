# Kafka 4.0.0 KRaft Mode - Multi-Broker Setup (3 Nodes)

[... existing content remains unchanged ...]

# ------------------------
# Performance Test Scripts
# ------------------------

# File: run-producer-perf-test.sh
#!/bin/bash
TOPIC="perf"
RECORDS=10000
THROUGHPUT=1000
RECORD_SIZE=1000
BROKER="localhost:9092"

# Auto-create topic if it doesn't exist
bin/kafka-topics.sh --bootstrap-server "$BROKER" --topic "$TOPIC" --create --if-not-exists --partitions 10 --replication-factor 3

# Run test and log output to CSV
bin/kafka-producer-perf-test.sh \
--topic "$TOPIC" \
--num-records "$RECORDS" \
--throughput "$THROUGHPUT" \
--record-size "$RECORD_SIZE" \
--producer-props bootstrap.servers="$BROKER" \
| tee producer_perf_results.csv

# File: run-consumer-perf-test.sh
#!/bin/bash
TOPIC="perf"
MESSAGES=10000
BROKER="localhost:9092"

# Run test and log output to CSV
bin/kafka-consumer-perf-test.sh \
--broker-list "$BROKER" \
--topic "$TOPIC" \
--messages "$MESSAGES" \
| tee consumer_perf_results.csv

# ------------------------
# Monitoring with Prometheus and JMX Exporter (Setup Notes)
# ------------------------

# To integrate with Prometheus, use Kafka's JMX metrics:
# 1. Download and configure Prometheus JMX Exporter (https://github.com/prometheus/jmx_exporter)
# 2. Add this to your Kafka startup:
#    KAFKA_JMX_OPTS="-javaagent:/path/to/jmx_prometheus_javaagent.jar=7071:/path/to/kafka-2_0_0.yml"
# 3. Restart brokers with updated env var
# 4. Configure Prometheus to scrape the JMX port (e.g., 7071)

# To test Kafka with JMeter:
# - Use the Kafka Load Generator Plugin for Apache JMeter
# - Configure producer/consumer threads to simulate load
# - Collect and export metrics to dashboards

# For Grafana integration:
# - Use Prometheus as a data source
# - Import Kafka dashboards from Grafana Labs or build custom panels
