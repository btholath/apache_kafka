# Kafka 4.0.0 KRaft Mode - Multi-Broker Setup (3 Nodes)

# ------------------------
# Shared Setup
# ------------------------

# Generate CLUSTER_ID (only once, on any node)
export CLUSTER_ID=$(bin/kafka-storage.sh random-uuid)
echo $CLUSTER_ID

# Replace this in all nodes below

# ------------------------
# Broker 1 Config: server-1.properties
# ------------------------
node.id=1
process.roles=broker,controller
listeners=PLAINTEXT://localhost:9092,CONTROLLER://localhost:9093
advertised.listeners=PLAINTEXT://localhost:9092
controller.listener.names=CONTROLLER
inter.broker.listener.name=PLAINTEXT
controller.quorum.voters=1@localhost:9093,2@localhost:9193,3@localhost:9293
log.dirs=/tmp/kraft-logs-1

# Format storage (one-time)
bin/kafka-storage.sh format -t $CLUSTER_ID -c config/kraft/server-1.properties

# ------------------------
# Broker 2 Config: server-2.properties
# ------------------------
node.id=2
process.roles=broker,controller
listeners=PLAINTEXT://localhost:9192,CONTROLLER://localhost:9193
advertised.listeners=PLAINTEXT://localhost:9192
controller.listener.names=CONTROLLER
inter.broker.listener.name=PLAINTEXT
controller.quorum.voters=1@localhost:9093,2@localhost:9193,3@localhost:9293
log.dirs=/tmp/kraft-logs-2

# Format storage
bin/kafka-storage.sh format -t $CLUSTER_ID -c config/kraft/server-2.properties

# ------------------------
# Broker 3 Config: server-3.properties
# ------------------------
node.id=3
process.roles=broker,controller
listeners=PLAINTEXT://localhost:9292,CONTROLLER://localhost:9293
advertised.listeners=PLAINTEXT://localhost:9292
controller.listener.names=CONTROLLER
inter.broker.listener.name=PLAINTEXT
controller.quorum.voters=1@localhost:9093,2@localhost:9193,3@localhost:9293
log.dirs=/tmp/kraft-logs-3

# Format storage
bin/kafka-storage.sh format -t $CLUSTER_ID -c config/kraft/server-3.properties

# ------------------------
# Startup Scripts
# ------------------------

# Start Broker 1
nohup bin/kafka-server-start.sh config/kraft/server-1.properties > logs/broker1.log 2>&1 &

# Start Broker 2
nohup bin/kafka-server-start.sh config/kraft/server-2.properties > logs/broker2.log 2>&1 &

# Start Broker 3
nohup bin/kafka-server-start.sh config/kraft/server-3.properties > logs/broker3.log 2>&1 &

# ------------------------
# Create Topic with Replication
# ------------------------
bin/kafka-topics.sh \
--bootstrap-server localhost:9092,localhost:9192,localhost:9292 \
--create \
--replication-factor 3 \
--partitions 7 \
--topic months

# Confirm Everything is Running
bin/kafka-topics.sh --bootstrap-server localhost:9092,localhost:9192,localhost:9292 --describe --topic months

# ------------------------
# systemd Service Example (for Broker 1)
# ------------------------
# File: /etc/systemd/system/kafka-broker1.service

[Unit]
Description=Kafka Broker 1
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/kafka
ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/kraft/server-1.properties
Restart=on-abnormal
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target

# Enable and start:
# sudo systemctl enable kafka-broker1
# sudo systemctl start kafka-broker1

# ------------------------
# Launch All Brokers (Quick Script)
# ------------------------
# File: start-all-brokers.sh
#!/bin/bash
nohup bin/kafka-server-start.sh config/kraft/server-1.properties > logs/broker1.log 2>&1 &
sleep 2
nohup bin/kafka-server-start.sh config/kraft/server-2.properties > logs/broker2.log 2>&1 &
sleep 2
nohup bin/kafka-server-start.sh config/kraft/server-3.properties > logs/broker3.log 2>&1 &
echo "All brokers started."
