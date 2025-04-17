# ------------------------
# Stop All Brokers (Quick Script)
# ------------------------
# File: stop-all-brokers.sh
#!/bin/bash
echo "Stopping all Kafka brokers..."
ps -ef | grep kafka.Kafka | grep -v grep | awk '{print $2}' | xargs kill -9
echo "All brokers stopped."