# Pedro Henrique Von Groll
# Passo a passo Kafka

Primeiro passo foi realizar o download do Kafka, para isso utilizei o seguinte comando.

`$wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz`

Após realizar do download, precisei descompactar o arquivo.

`$wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz`

Acessei o diretório.

`$cd kafka_2.13-3.3.1/`

Para realizar essa atividade é necessário utilizar o docker compose, então realizei a instalção dele também.

`$sudo apt install docker-compose`

Criei um arquivo chamado "docker-compose.yml" nesse arquivo contém o seguinte conteúdo.

```version: '2'
services:
  zookeeper:
    image: wurstmeister/zookeeper:latest
    ports:
     - "2181:2181"

  kafka1:
    image: wurstmeister/kafka:latest
    ports:
     - "9292:9292"
    expose:
     - "9292"
    environment:
      KAFKA_ADVERTISED_LISTENERS: INSIDE://kafka1:9093,OUTSIDE://localhost:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_LISTENERS: INSIDE://0.0.0.0:9093,OUTSIDE://0.0.0.0:9092
      KAFKA_INTER_BROKER_LISTENER_NAME: INSIDE
      KAFKA_ZOOKEEPER_CONNECT: "zookeeper:2181"
      KAFKA_BROKER_ID: 1
      KAFKA_NUM_PARTITIONS: 3
      KAFKA_REPLICATION_FACTOR: 3

  kafka2:
    image: wurstmeister/kafka:latest
    ports:
     - "9494:9494"
    expose:
     - "9494"
    environment:
      KAFKA_ADVERTISED_LISTENERS: INSIDE://kafka2:9095,OUTSIDE://localhost:9094
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_LISTENERS: INSIDE://0.0.0.0:9095,OUTSIDE://0.0.0.0:9094
      KAFKA_INTER_BROKER_LISTENER_NAME: INSIDE
      KAFKA_ZOOKEEPER_CONNECT: "zookeeper:2181"
      KAFKA_BROKER_ID: 2
      KAFKA_NUM_PARTITIONS: 3
      KAFKA_REPLICATION_FACTOR: 3

  kafka3:
    image: wurstmeister/kafka:latest
    ports:
     - "9696:9696"
    expose:
     - "9696"
    environment:
      KAFKA_ADVERTISED_LISTENERS: INSIDE://kafka3:9097,OUTSIDE://localhost:9096
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_LISTENERS: INSIDE://0.0.0.0:9097,OUTSIDE://0.0.0.0:9096
      KAFKA_INTER_BROKER_LISTENER_NAME: INSIDE
      KAFKA_ZOOKEEPER_CONNECT: "zookeeper:2181"
      KAFKA_BROKER_ID: 3
      KAFKA_NUM_PARTITIONS: 3
      KAFKA_REPLICATION_FACTOR: 3
```

Após configurar o arquivo, acessei o diretório do trabalho e rodei o seguinte comando.

`$docker-compose up -d`

Verifiquei se os container criados estavem em execução.

`$docker-compose ps`

![execução-containers](https://github.com/padoinedson/sd2023exercicios/assets/141967871/e2fa1b1a-4680-4f69-bbf5-8013b14dfeb9)

# Produtor e Consumidor normal (Todos os nodos ON)

Para começar criar o tópico que a atividade solicita precisei acessar o container.

`$docker exec -it kafka_kafka1_1 bash`

Dentro do container, utilizei o comando para criar um tópico com o nome de "rainbow-six"

`$kafka-topics.sh --create \
--topic rainbow-six \
--partitions 3 \
--replication-factor 3 \
--bootstrap-server kafka1:9093`

![criação-topico](https://github.com/padoinedson/sd2023exercicios/assets/141967871/42936769-7f3e-4953-a0ef-8e9f41e00b9f)

Após criar o tópico, utilizei um comando para verificar se o mesmo havia sido criado corretamente.

`$kafka-topics.sh --list --bootstrap-server kafka1:9093`

![tópicos existentes](https://github.com/padoinedson/sd2023exercicios/assets/141967871/4147af35-1a5e-4cdf-883d-740d7528f8cd)

Agora comecei a enviar as mensagem para o tópico.

`$kafka-console-producer.sh --topic rainbow-six --bootstrap-server kafka1:9093`

![envio de mensagens](https://github.com/padoinedson/sd2023exercicios/assets/141967871/54965bd3-82a1-43bc-945a-cae27613bea6)

Após enviar as mensagens, abri um terminal para que fosse possível consumir as mensagens.

`$docker exec -it kafka_kafka1_1 bash`

`$kafka-console-consumer.sh --topic rainbow-six --from-beginning --bootstrap-server kafka1:9093`

![consumir mensagens](https://github.com/padoinedson/sd2023exercicios/assets/141967871/ff5386b9-6453-483d-8a5f-a2e490d1f58f)

# Produtor e Consumidor com um dos Nodos OFF

Para isso comecei derrubando o primeiro nó.

`$sudo docker stop kafka_kafka1_1`

Após isso verifiquei o status dos container que estavam em execução.

`$sudo docker ps`

![no derrubado](https://github.com/padoinedson/sd2023exercicios/assets/141967871/5c55aeff-a495-4bd0-b2a1-962b741b9090)

Após verificar isso, verifiquei se as mensagens não haviam se perdidos, mas havia ficado certo, então reergui o container.

`$sudo docker start kafka_kafka1_1`

`$sudo docker ps`

![no reerguido](https://github.com/padoinedson/sd2023exercicios/assets/141967871/f6ccee6e-4250-46af-b234-c4f6e2783a11)

![mensagem pós queda do no](https://github.com/padoinedson/sd2023exercicios/assets/141967871/b8d2061b-4341-4164-aa1d-284084148e31)

Realizado essas etapas, abri 3 terminais, um como produtor e os outros dois como consumidor, verifiquei que eles estavam recebendo o nome dos operadores em tempo real.

# Consumidor com leitura em GRUPO

Para que o consumidor pudesse realizar a leitura em grupo precisei utilizar outro comando.

`$kafka-console-consumer.sh --topic rainbow-six --bootstrap-server kafka1:9093 --from-beginning --group meu-grupo`

![leitura em grupo](https://github.com/padoinedson/sd2023exercicios/assets/141967871/4a346a9f-469d-4272-b65e-736acaa4f58b)

# NOVIDADE EM RELAÇÃO AO EXEMPLO DADO EM AULA

Para a novidade, realizei um comando que em resumo, le um conteúdo do arquivo mensagens.txt e realiza o envio dessas mensagens para o tópico rainbow-six.

**ARQUIVO MENSAGENS.TXT**

![mensagens txt](https://github.com/padoinedson/sd2023exercicios/assets/141967871/4bdcf2d2-6468-4c99-8d80-41deff643219)

**COMANDO DA LEITURA**

`$sudo cat /home/pedro-kafka/Documents/kafka/mensagens.txt | sudo docker exec -i kafka_kafka1_1 kafka-console-producer.sh --topic rainbow-six --bootstrap-server kafka1:9093`

**INICIANDO DOCKER E CONSUMINDO AS NOVAS MENSAGENS**

`$sudo docker exec -it kafka_kafka1_1 kafka-console-consumer.sh --topic rainbow-six --bootstrap-server kafka1:9093 --from-beginning`

![novidade](https://github.com/padoinedson/sd2023exercicios/assets/141967871/7556a01c-0f4d-4a5a-afae-0b5e0452191e)`


# ENVIO DOS PRINTS REFERENTE AO GIT ADD, GIT COMMIT E GIT PUSH

**GIT ADD, GIT COMMIT E GIT PUSH**

![upload github](https://github.com/padoinedson/sd2023exercicios/assets/141967871/be1b2a4a-5df7-4941-8bc0-4c1cc001a9a5)
