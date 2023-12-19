Aluno: Vinicius Smaniotto Goulart

Este resumo apresenta as principais etapas do tutorial para instalação, utilização e encerramento dos serviços Kafka e ZooKeeper usando Docker Compose.

**1 - Instalação:**
No Terminal 1:
**Instale o Docker Compose:**
$ sudo apt install docker-compose

**Crie o arquivo docker:**
$ nano docker-compose.yml

**Cole o conteúdo a seguir:**
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
      - "moby:127.0.0.1"


**Execute os serviços:** 
$ sudo docker-compose up -d (dentro da pasta com o arquivo "docker-compose.yml")

**No Terminal 2:**
**Verifique o status dos containers:** 
$ sudo docker-compose ps ou $ sudo docker ps
**2 - Utilização:**
            **No Terminal 3:**
**Acesse um container:** 
$ sudo docker exec -it (nome do container) bash

**Crie um tópico:** 
$ kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic (topico da sua escolha)

**No Terminal 3:**
**Visualize informações do tópico:**
$ kafka-topics --describe --bootstrap-server localhost:29092 --topic (topico da sua escolha)

**Liste todos os tópicos:**
$ kafka-topics --list --bootstrap-server localhost:29092

**No Terminal 4:**
**Acesse um container:** 
$ sudo docker exec -it (nome do container) bash

**Produza eventos no tópico:** 
$ kafka-console-producer --broker-list localhost:29092 --topic (tópico da sua escolha)

**No Terminal 5:**
**Acesse um container:** 
$ sudo docker exec -it (nome do container) bash

**Consuma novos eventos:** 
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic (tópico da sua escolha)

**No Terminal 5:**
Leia todos os eventos armazenados: 
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic (tópico da sua escolha) --from-beginning

**Receba todas as inserções de um grupo:** 
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic (tópico da sua escolha) --from-beginning --group (nome do grupo)

**3 - Parar os Serviços Kafka e ZooKeeper:**
  
**No Terminal 1:**
**Execute o comando para baixar o container que foi utilizado inicialmente:**
$ sudo docker stop (nome do container)

**Execute o comando para visualizar se foi dado a baixa no sistema:**
$ sudo docker ps

   **No Terminal 3, 4, 5 :**
**Execute o comando para visualizar em outro container para ver se as mensagens estão salvas:**
**primeiro comando:** 
$ sudo docker exec -it (nome do container) bash

**segundo comando:**
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic (tópico da sua escolha) --from-beginning


**NOVIDADE:**

Pode ser útil ver onde estão seus consumidores. Temos uma ferramenta que mostra a posição de todos os consumidores dentro de um grupo de consumidores e a defasagem do consumidor ao final da adesão. Execute o comando:
$ kafka-consumer-groups --bootstrap-server localhost:29092 --describe --group (nome do grupo)

**Link para os prints:**

https://docs.google.com/document/d/1yCoqdjhESy7-rVTDcmNga9NKWYGcIe28h9hZUtJA4GM/edit?usp=sharing


