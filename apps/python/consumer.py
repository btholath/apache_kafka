# consumer.py
from kafka import KafkaConsumer
import json

# Initialize Kafka consumer
consumer = KafkaConsumer(
    'demo-topic',
    bootstrap_servers='localhost:9092',
    auto_offset_reset='earliest',       # Start from beginning
    enable_auto_commit=True,
    group_id='my-consumer-group',
    value_deserializer=lambda v: json.loads(v.decode('utf-8'))
)

print('Listening for messages...')

for message in consumer:
    print(f"Received: {message.value}")
