from kafka import KafkaProducer
import json
import random
from time import sleep
from datetime import datetime

# Create an instance of the Kafka producer
producer = KafkaProducer(bootstrap_servers='localhost:29092',
                            value_serializer=lambda v: str(v).encode('utf-8'))

# Call the producer.send method with a producer-record
print("Ctrl+c to Stop")
lista = ['Inter Maior do Sul', 'Inter Campeão Brasileiro 2024', 'Grêmio Rebaixado', 'Inter Campeão de Tudo', 'O Inter é Gigante']
while True:
    producer.send('mensagens', random.choice(lista))
