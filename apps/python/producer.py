# producer.py
from kafka import KafkaProducer
import json

# Initialize Kafka producer
producer = KafkaProducer(
    bootstrap_servers='146.190.130.199:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')  # Serialize JSON
)

# Send a few messages to the topic
for i in range(5):
    data = {'id': i, 'message': f'Hello Kafka {i}'}
    producer.send('demo-topic', value=data)
    print(f'Sent: {data}')

producer.flush()
producer.close()


""" OUTPUT
/home/bijut/.virtualenvs/aws_apps/bin/python /home/bijut/aws_apps/apache_kafka/apps/python/producer.py 
Sent: {'id': 0, 'message': 'Hello Kafka 0'}
Sent: {'id': 1, 'message': 'Hello Kafka 1'}
Sent: {'id': 2, 'message': 'Hello Kafka 2'}
Sent: {'id': 3, 'message': 'Hello Kafka 3'}
Sent: {'id': 4, 'message': 'Hello Kafka 4'}
"""