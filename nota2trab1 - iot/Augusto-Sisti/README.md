Aluno: Augusto Eduardo Sisti

# Kafka

Para fazer o trabalho, será preciso baixar o docker
```
sudo apt install docker
sudo apt install docker.io
sudo apt install docker-compose
```
Criar a pasta do docker
```
mkdir kafka
```
Para acessar a pasta
```
cd kafka
```
Criar o arquivo do docker-compose.yml com as configurações
```
nano docker-compose.yml
```
---
version: '2'
services:
  zookeeper-1:
	image: confluentinc/cp-zookeeper:latest
	environment:
  	ZOOKEEPER_SERVER_ID: 1
  	ZOOKEEPER_CLIENT_PORT: 22181
  	ZOOKEEPER_TICK_TIME: 2000
  	ZOOKEEPER_INIT_LIMIT: 5
  	ZOOKEEPER_SYNC_LIMIT: 2
  	ZOOKEEPER_SERVERS: localhost:22888:23888;localhost:32888:33888;localhost:42888:43888
	network_mode: host
	extra_hosts:
  	- "moby:127.0.0.1"

  zookeeper-2:
	image: confluentinc/cp-zookeeper:latest
	environment:
  	ZOOKEEPER_SERVER_ID: 2
  	ZOOKEEPER_CLIENT_PORT: 32181
  	ZOOKEEPER_TICK_TIME: 2000
  	ZOOKEEPER_INIT_LIMIT: 5
  	ZOOKEEPER_SYNC_LIMIT: 2
  	ZOOKEEPER_SERVERS: localhost:22888:23888;localhost:32888:33888;localhost:42888:43888
	network_mode: host
	extra_hosts:
  	- "moby:127.0.0.1"

  zookeeper-3:
	image: confluentinc/cp-zookeeper:latest
	environment:
  	ZOOKEEPER_SERVER_ID: 3
  	ZOOKEEPER_CLIENT_PORT: 42181
  	ZOOKEEPER_TICK_TIME: 2000
  	ZOOKEEPER_INIT_LIMIT: 5
  	ZOOKEEPER_SYNC_LIMIT: 2
  	ZOOKEEPER_SERVERS: localhost:22888:23888;localhost:32888:33888;localhost:42888:43888
	network_mode: host
	extra_hosts:
  	- "moby:127.0.0.1"

  kafka-1:
	image: confluentinc/cp-kafka:latest
	network_mode: host
	depends_on:
  	- zookeeper-1
  	- zookeeper-2
  	- zookeeper-3
	environment:
  	KAFKA_BROKER_ID: 1
  	KAFKA_ZOOKEEPER_CONNECT: localhost:22181,localhost:32181,localhost:42181
  	KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:19092
	extra_hosts:
  	- "moby:127.0.0.1"

  kafka-2:
	image: confluentinc/cp-kafka:latest
	network_mode: host
	depends_on:
  	- zookeeper-1
  	- zookeeper-2
  	- zookeeper-3
	environment:
  	KAFKA_BROKER_ID: 2
  	KAFKA_ZOOKEEPER_CONNECT: localhost:22181,localhost:32181,localhost:42181
  	KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:29092
	extra_hosts:
  	- "moby:127.0.0.1"

  kafka-3:
	image: confluentinc/cp-kafka:latest
	network_mode: host
	depends_on:
  	- zookeeper-1
  	- zookeeper-2
  	- zookeeper-3
	environment:
  	KAFKA_BROKER_ID: 3
  	KAFKA_ZOOKEEPER_CONNECT: localhost:22181,localhost:32181,localhost:42181
  	KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:39092
	extra_hosts:
  	- "moby:127.0.0.1`

Executar o docker compose:
```
sudo docker-compose up -d
```
-d = background
![Alt text](<Execução Docker Compose-1.jpeg>)

Para verificar todos os nós dos contêineres:
```
sudo docker-compose ps
```
![Alt text](<Conteiner em execução-1.jpeg>)

Para entrar no container:
```
sudo docker exec -it kafka_kafka-1_1 bash
```

Criar o tópico "Futebol" com 3 partições e fator de replicação também 3
```
kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic Futebol
```
![Alt text](<Criação do Topic-1.jpeg>)

Postar dentro do tópico:
```
kafka-console-producer --broker-list localhost:29092 --topic Futebol
``` 
Fazer postagens dentro do tópico como o exemplo abaixo
```
Internacional
Grêmio
Fluminense
Flamengo
Palmeiras
Botafogo
```
`ctrl + c` para encerrar
![Alt text](<Enviando Mensagens dentro do Conteiner-1.jpeg>)

Abrir mais um terminal, e executar o comando para  acessar um contêiner:
```
sudo docker exec -it kafka_kafka-1_1 bash
```

Receber o que foi escrito no tópico desde sua criação e continuar recebendo o que está sendo escrito nele:
```
kafka-console-consumer --bootstrap-server localhost:29092 --topic Futebol --from-beginning
```
![Alt text](<Recebendo Mensagens-1.jpeg>)

Para testar o se o tópico recebe em tempo real, enviamos mais nomes no terminal 1 e verificamos se recebe no outro terminal:
```
kafka-console-producer --broker-list localhost:29092 --topic Futebol


São Paulo
Santos
```
![Alt text](<Enviando Mais msg-1.jpeg>)
`ctrl + c` para encerrar

Terminal recebeu em tempo real as postagens 
![Alt text](<Consumer Recebendo Tempo real-1.jpeg>)

`ctrl + c` para encerrar

`exit` para sair do contêiner

## Derrubar 1 nó, para teste de alteração:
Derrubar nó:
```
sudo docker stop kafka_kafka-1_1
```
Para verificar os contêineres em execução
```
sudo docker ps
```
![Alt text](<nó derrubado-1.jpeg>)

Em outro terminal, acessar mais um contêineres

```
sudo docker exec -it kafka_kafka-2_1 bash
```

Receber as postagens:

```
kafka-console-consumer --bootstrap-server localhost:29092 --topic Futebol --from-beginning
```

![Alt text](<Mensagens Sem alterações-1.jpeg>)

Mensagens sem nenhuma alteração

`ctrl + c` para encerrar

## Subir o nó derrubado

Executar novamente o nó que havia sido derrubado
```
sudo docker start kafka_kafka-1_1
```

Para verificar os contêineres em execução:
```
sudo docker ps
```
![Alt text](<nó on-1.jpeg>)

Em outro terminal, verificar as postagens
```
kafka-console-consumer --bootstrap-server localhost:29092 --topic Futebol --from-beginning
```
![Alt text](<Mensagens sem mudanças-1.jpeg>)

Mensagens iguais, sem alterações por causa do fator de replicação

`ctrl + c` para encerrar

para sair do contêiner `exit`

### Testando envio e recebimento de mensagem em tempo real
No terminal 1, acessar um container e o deixar como consumidor:
```
sudo docker exec -it kafka_kafka-1_1 bash
```
```
kafka-console-consumer --bootstrap-server localhost:29092 --topic Futebol --from-beginning
```

No terminal 2, acessar um container e o deixar como consumidor:
```
sudo docker exec -it kafka_kafka-2_1 bash
```
```
kafka-console-consumer --bootstrap-server localhost:29092 --topic Futebol --from-beginning
```

No terminal 3, acessar um container e o deixar como produtor:
```
sudo docker exec -it kafka_kafka-3_1 bash
```
```
kafka-console-producer --broker-list localhost:29092 --topic Futebol
```
Neste enviar mensagens e validar nos demais se estão recebendo:
```
Juventude
Fortaleza
CRB
Atletico MG
```
![Alt text](<producer msg-1.jpeg>)
![Alt text](<Consumer msg-1.jpeg>)
![Alt text](<Consumer msg 2-1.jpeg>)


# Novidades

## Gerador de Mensagens com Script Python
É necessário fazer a instalação
```
sudo apt install python3.10
sudo apt install python3-pip
sudo apt install python3-virtualenv
```

Dentro da pasta kafka, criar uma pasta com virtualenv
```
virtualenv teste
```
Para ativar o ambiente
```
source teste/bin/activate
```
Criar o arquivo `producer.py`: 
```
nano teste/producer.py
``` 
Conteúdo do arquivo
```
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
```
![Alt text](<Código Python-1.jpeg>)

Abrir outro terminal
Acessar um contêiner
Criar o tópico `mensagens` 
```
sudo docker exec -it kafka_kafka-2_1 bash

kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic mensagens

kafka-console-consumer --bootstrap-server localhost:29092 --topic mensagens --from-beginning
```

no primeiro terminal, dentro da pasta kafka, instalar o pacote kafka para python:
```
pip install kafka-python
```
rodar o script
```
python test/producer.py
```
![Alt text](<Rodando Script Python-2.jpeg>)

`ctrl + c` para encerrar

Terminal recebendo as mensagens
![Alt text](<Mensagens Geradas-1.jpeg>)

Desativar o virtualenv:
```
deactivate
```

Finalizar derrubando os contêiners
```
sudo docker-compose down
```

## Print Git
![Alt text](<git.png>)



