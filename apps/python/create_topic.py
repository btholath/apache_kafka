from kafka.admin import KafkaAdminClient, NewTopic

admin = KafkaAdminClient(bootstrap_servers='localhost:9092')
topic = NewTopic(name="demo-topic", num_partitions=1, replication_factor=1)

try:
    admin.create_topics(new_topics=[topic], validate_only=False)
    print("Topic created")
except Exception as e:
    print(f"Topic may already exist: {e}")
finally:
    admin.close()
