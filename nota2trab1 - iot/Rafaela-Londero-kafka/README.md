Rafaela Londero


Criação do ambiente (nodos, partição, fator de replicação)


Primeiramente será realizada a configuração do ambiente com docker compose, para isso é necessário criar um arquivo de configuração chamado docker-compose.yml, este arquivo estará dentro de uma pasta chamada kafka.


Conteúdo do arquivo yml


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


No terminal 1


Será necessário realizar a instalação do docker compose, que será feito com o seguinte comando


instalando o docker compose


$ sudo apt install docker-compose 


subindo o docker


$ sudo docker-compose up


Agora os containers estão rodando.




  



No terminal 2


Para verificar o status dos containers


$ sudo docker-compose ps


  



Com os containers prontos, será feita a criação dos tópicos dentro de um deles, o escolhido foi o kafka_kafka-1_1


> Criação de Tópicos


No terminal 3


No terceiro terminal será acessado o container escolhido


$ sudo docker exec -it kafka_kafka-1_1 bash 


  



Dentro do container, será criado um tópico chamado calor com o seguinte comando


$ kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic calor  


  



Com o tópico criado é possível fazer a visualização deste tópico 


  



No terminal 4




PRODUTOR


Agora com o tópico criado, no terminal 4 será acessado o mesmo container novamente para realizar a criação do produtor, e assim mandar mensagens para o consumidor.


acessando o container novamente no terminal 4


$ sudo docker exec -it kafka_kafka-1_1 bash  


Então será feito o post no broker  do console do producer, onde as mensagens serão enviadas


$ kafka-console-producer --broker-list localhost:29092 --topic calor  


Escrevendo mensagens no produtor para posteriormente serem lidas no consumidor


  



CONSUMIDOR


No terminal 5


Com as mensagens já enviadas pelo producer, será realizada a leitura das mesmas pelo consumidor.


No terminal 5 será acessado o mesmo container onde foi feito o producer para ser feito o consumidor


$ sudo docker exec -it kafka_kafka-1_1 bash  


Dentro do container, então será feito a operação get no broker para buscar as mensagens enviadas, esse comando apenas mostra as novas mensagens enviadas


$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor


Para visualizar as anteriores é usado esse comando, assim irá listar todas as mensagens desde o início do producer


$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning  


  



PARANDO UM DOS NÓS


Agora, que já foi criado um tópico, feito o envio de mensagens pelo producer e as mesma lida pelo consumer, um dos nós será parado, para demonstrar que nenhuma informação será perdida, mesmo com um dos nós cair.


Os nós existentes podem ser visualizados através do comando


$ sudo docker ps


O nó escolhido foi o kafka_kafka_3_1
  



Subindo o container kafka_kafka_3_1 novamente e parando o kafka_kafka_1_1


  



Agora para ver se as mensagens enviadas anteriormente continuam no container será acessado o container kafka_kafka_3_1, assim garantindo que nada foi perdido.


Comando para exibir as mensagens enviadas


$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning  


  



NOVIDADE DO KAFKA


Produzir Mensagens a partir de um Arquivo


Há muitas coisas que podem ser feitas com o kafka, uma delas, é buscar as mensagens de um arquivo ao invés de escrevê-las à mão, para isso será necessário ter um arquivo com uma mensagem.


Para criar um arquivo com alguma mensagem é usado o comando echo, assim informando o nome do arquivo que vai ter essa mensagem armazenada.


$ echo "Mensagem de teste" > mensagem.txt


Escrevendo dentro do container do kafka uma mensagem em um arquivo


  



Agora com o arquivo criado, é realizado um comando cat do arquivo passando uma operação de producer, para escrever a mensagem contida no arquivo no kafka.


cat mensagem.txt | kafka-console-producer --topic calor --bootstrap-server localhost:29092


Essas mensagens podem ser lidas em outro terminal com o comando a seguir


$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning  


  



E também, as mensagens escritas no producer do kafka podem ser exportadas para um arquivo, que podem ser posteriormente lidos, assim podendo compartilhar as mensagens mais facilmente.


Exportando todas as mensagens do tópico calor para dentro de um arquivo chamado new-messages.txt


$ kafka-console-consumer --topic calor --bootstrap-server localhost:29092 --from-beginning > new-messages.txt
  





Agora será verificado a criação do arquivo, e também fazendo cat do mesmo para escrever a mensagem que está dentro no kafka


Com o comando ls é possível ver os arquivos que estão dentro do container


$ ls
  





Pode ser feita a verificação conteúdo do arquivo exportado com o seguinte comando


$ cat new-messages.txt


Link do Google Docs com os prints organizados https://docs.google.com/document/d/1-xcMv8jMMeaUGYY_2p2dXJ9Thy9C6pMR1ETr1xEP7JQ/edit?usp=sharing
