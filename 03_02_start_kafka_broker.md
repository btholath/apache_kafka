
Start Apache Kafka

(1) Modify in server.properties file
process.roles=broker,controller
node.id=1
controller.quorum.voters=1@localhost:9093
listeners=PLAINTEXT://localhost:9092,CONTROLLER://localhost:9093
inter.broker.listener.name=PLAINTEXT
controller.listener.names=CONTROLLER
log.dirs=/tmp/kraft-combined-logs



(2) Format storage
root@ubuntu-kafka:~/downloads/kafka# pwd
/root/downloads/kafka

root@ubuntu-kafka:~/downloads/kafka# 
root@ubuntu-kafka:~/downloads/kafka# 
bin/kafka-storage.sh format -t $(uuidgen) -c config/kraft/server.properties
Formatting metadata directory /tmp/kraft-combined-logs with metadata.version 4.0-IV3.



(3) Start the broker
root@ubuntu-kafka:~/downloads/kafka#
bin/kafka-server-start.sh config/kraft/server.properties


