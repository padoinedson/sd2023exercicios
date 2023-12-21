## criar arquivo docker-compose.yml
```sh
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
```
## Docker compose up
no terminal 1:
```sh
sudo docker-compose up
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186985358760620152/image.png?ex=65953d42&is=6582c842&hm=259d1751546482af4f0e60014ff5ad0e1733ff04a5406621455ce7a021856a4f&=&format=webp&quality=lossless)

## Containers levantados com todos os nodos
no terminal 2:
```sh
sudo docker compose ps
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186983014517968926/image.png?ex=65953b13&is=6582c613&hm=6188e372aa5202caaf0f247107fa68d1224a9c4311b78b0728da4e059d457c98&=&format=webp&quality=lossless)

## Criar topicos e mandar mensagens como producer e ler como consumer
no terminal 3:
acessar container
```sh
sudo docker exec -it trabiot-kafka-1-1 bash
```

criar topico zap
```sh
kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic zap
```

mandar zap
```sh
kafka-console-producer -- broker-list localhost:29092 --topic zap
```

![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186983448171249715/image.png?ex=65953b7b&is=6582c67b&hm=0f64792d044d86ea7e9872d149d601580cf79c55843a7e5f9b87b552d7e834cb&=&format=webp&quality=lossless&width=720&height=152)

no terminal 4:
acessar container
```sh
sudo docker exec -it trabiot-kafka-1-1 bash
```

ler zap mandado
```sh
kafka-console-consumer -- broker-list localhost:29092 --topic zap --from-beginning
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186983726266208316/image.png?ex=65953bbd&is=6582c6bd&hm=092c11498dc4d10718659378b79928d6c281641deaea84792e66297b5427f492&=&format=webp&quality=lossless&width=720&height=135)

## Mandar mensagens como producer e ler sem um nodo
no terminal 2:
```sh
sudo docker stop trabiot-kafka-3-1
```
verificar nodos
```sh
sudo docker ps
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186983114766024778/image.png?ex=65953b2b&is=6582c62b&hm=b0948f1d12cd52f42845f28b8743eddbd3bbed8056b20679acba71d497397ed7&=&format=webp&quality=lossless&width=720&height=206)
no terminal 3:

mandar zap
```sh
kafka-console-producer -- broker-list localhost:29092 --topic zap
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186983545005162556/image.png?ex=65953b92&is=6582c692&hm=75f9363a9f3f8704aed6aca66b1ae16031f2746da8767eb1d8e49a8f44ecee59&=&format=webp&quality=lossless&width=720&height=111)

no terminal 4:

ler zap mandado
```sh
kafka-console-consumer -- broker-list localhost:29092 --topic zap --from-beginning
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186984265364291654/image.png?ex=65953c3d&is=6582c73d&hm=8fe7186b35ee6e1ac2c451d86966f26ed18807c4d30b9eb28ae652cb2081a9da&=&format=webp&quality=lossless&width=720&height=201)

## Mandar mensagens como producer e ler sem um nodo
no terminal 2:
```sh
sudo docker start trabiot-kafka-3-1
```
verificar nodos
```sh
sudo docker ps
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186984524081541120/image.png?ex=65953c7b&is=6582c77b&hm=6b3548aaaaa49650614fe0610ff12e4b3a3b3b2a1a7cd6f3d2651674ab14b407&=&format=webp&quality=lossless&width=720&height=256)
no terminal 3:

mandar zap
```sh
kafka-console-producer -- broker-list localhost:29092 --topic zap
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1187292182948876328/image.png?ex=65965b03&is=6583e603&hm=98d5a604ebbd8fbef6a2115b0a443b2c38c4fa87e75c492eefa4d82cf5eb5374&=&format=webp&quality=lossless&width=720&height=133)

no terminal 4:

ler zap mandado
```sh
kafka-console-consumer -- broker-list localhost:29092 --topic zap --from-beginning
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1187292526013591552/image.png?ex=65965b55&is=6583e655&hm=f4a323c3d0741555b235f135a9d15a62e97a28415014ce7e937811d4f2b40ee9&=&format=webp&quality=lossless&width=720&height=121)

## Leitura em grupo

no terminal 4:

ler mensagem mandada no grupo zapzap
```sh
kafka-console-consumer --bootstrap-server localhost:29092 --topic zap --from-beginning --group zapzap
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1187295515596046366/image.png?ex=65965e1d&is=6583e91d&hm=ee853af5989ebe0b22483c3da6c203d326d6ccb06e59468e212138a5cc007682&=&format=webp&quality=lossless&width=720&height=204)

## Novidades
foi mandado a sequencia de numeros gerados aleatoriamente a partir do arquivo text.txt para o zap
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1187282893689597982/image.png?ex=6596525c&is=6583dd5c&hm=9b60b82b3d4936c784f5cdf1fe86cb12dab1a3f22044b5909e016de8705d59a8&=&format=webp&quality=lossless)
```sh
cat text.txt | sudo docker exec -i trabiot-kafka1-1 kafka-console-producer --topic zap --bootstrap-server localhost:29092
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1187283100493955112/image.png?ex=6596528d&is=6583dd8d&hm=733424ef2eb01c8d7317cf9acc45e70912f7104f0866909432c29f87b0807f03&=&format=webp&quality=lossless&width=720&height=279)