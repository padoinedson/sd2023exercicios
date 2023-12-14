Sistemas Distribuídos
Aplicação de kafka ou K8S em aplicação real
Lenya Ribeiro Ferreira

<p align="center">Explicação dos passos para instalação e realização das etapas</p>

<h1 align="center"><<<<< a) Criação do ambiente (nodos, partição, fator de replicação)
 >>>>></h1>

1. Visto que o trabalho vai ser feito com foco em Kafka e uso de Docker, é necessário montar o arquivo "docker-compose.yml" que tenha: nodos = 3, broquer = 3, partição = 3 e fator de replicação de dados = 3. A configuração do arquivo necessário está disponível abaixo:

	a. 
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

      b. Depois, certifique-se de que está na pasta com o arquivo yml feito anteriormente e rode "sudo apt install docker-compose" e "sudo docker-compose up".

      ![github-small](https://i.imgur.com/BRw8QVF.png)


<h1 align="center"><<<<< Extra) Produtor e Consumidor normal (todos os nodos on) >>>>></h1>

1. Antes de criar os consumidores e produtores, é necessário criar o tópico a ser utilizado. Abaixo será explicitado os comandos utilizados na realização do trabalho.

	a. Para utilizar o container criado anteriormente, "sudo docker exec -it trabalhokafka_kafka-1_1 bash"

	b. Para criar um tópico é necessário usar "kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic trabalhokafka". Como pode ser visto, o nome do mesmo será "trabalhokafka".

	c. Com "kafka-topics --describe --bootstrap-server localhost:29092 --topic trabalhokafka" pode-se ver as informações do tópico. Ainda não foram produzidas mensagens.

2. Para enviar eventos é necessário criar um produtor, então deve-se primeiro acessar o container selecionado.

	a. Em um novo terminal, usa-se o comando "sudo docker exec -it trabalhokafka_kafka-1_1 bash", com "trabalhokafka_kafka-1_1" sendo utilizado neste caso especificamente, mas podendo variar.

	b. Usa-se "kafka-console-producer --broker-list localhost:29092 --topic trabalhokafka" para que criar o produtor. Assim, pode-se enviar mensagens.

3. Para visualizar as mensagens enviadas é necessário criar consumidores.

	a. Usa-se, em um novo terminal, o comando "sudo docker exec -it trabalhokafka_kafka-1_1 bash" para entrar novamente no container.

	b. Usa-se "kafka-console-consumer --bootstrap-server localhost:29092 --topic trabalhokafka" para poder observar as mensagens que serão enviadas pelo produtor.

	c. Se quiser ter a possibilidade de ver todas as mensagens enviadas anteriormente, acrescente "--from-beginning" no final do comando anterior.

  ![github-small](https://i.imgur.com/MVDBdf6.png)
  Produtor.


  ![github-small](https://i.imgur.com/3I9XWil.png)
  Consumidor.

<h1 align="center"><<<<< Extra) Produtor e Consumidor com um dos nodos off (derrubar um nodo)
 >>>>></h1>

 1. Foi selecionado o nó de um dos consumidores para ser derrubado.

 	a. Foi rodado o comando "sudo docker stop 58a999141da5" para parar o container.

 	b. Foi utilizado "sudo docker ps" para conferir se tudo havia ocorrido conforme esperado.

  ![github-small](https://i.imgur.com/egFadJ5.png)

<h1 align="center"><<<<< Extra) Produtor e Consumidor com um nodo novo (adicionar um nodo)
 >>>>></h1>

 1. Depois de derrunar um nó no passo anterior, foi adicionado um novo nó consumidor. Podem ser recuperadas as mensagens enviadas enquanto o processo anterior ocorria.

 ![github-small](https://i.imgur.com/k7KziAs.png)

<h1 align="center"><<<<< Extra) Consumidor com leitura em grupo >>>>></h1>

1. Para fazer o uso de leitura em grupo, deve-se indicar o nome do grupo no final do comando utilizado para criar o produtor e consumidor.

	a. Assim, usa-se "kafka-console-consumer --bootstrap-server localhost:29092 --topic trabalhokafka --from-beginning --group 1".

  ![github-small](https://i.imgur.com/0eP37qw.png)
  Produtor.

  ![github-small](https://i.imgur.com/5NaTP10.png)
  Consumidor.

<h1 align="center"><<<<< Extra) Novidades em relação ao exemplo de aula >>>>></h1>

Conduktor é uma ferramenta simples que pode ser usada para monitorar o broker Kafka. Com ele, é possível observar as características tais quais os tópicos e partições. Além disso, é possível produzir e consumir mensagens com ele.

1. Visto que o processo foi realizado em uma máquina diferente, com Linux instalado, foi necessário realizar a instalação e configuração do Kafka neste novo laptop.

  a. Versão selecionada foi a Scala 2.12  - kafka_2.12-2.4.0.tgz (asc, sha512).

  b. É necessário ir ao diretório onde o download foi feito e executar os comandos "tar -xvf kafka_2.12-2.4.0.tgz" para extrair os arquivos e "mv kafka_2.12-2.4.0 kafka" para renomear o arquivo. O "kafka" então foi movido para o home com "mv kafka/ ~". 

  c. Foi modificado o arquivo bashrc adicionando a linha "export PATH=~/.local/bin:$PATH" e "export PATH=/home/pc/kafka/bin:$PATH", com o comando "gedit .bashrc"

  d. Foram criadas pastas dentro de "kafka", chamadas "data", "zookeeper" e "kafka" com o comando mkdir, para melhor organização.

  e. Com o uso do comando "gedit zookeeper.properties", foi alterado o diretório de "dataDir" em "zookeeper.properties", mudando "/tmp/zookeeper" para "/home/pc/kafka/data/zookeeper".

  f. Com o comando "gedit server.properties", foi alterado o diretório de "log.dirs" em "server.properties" de "tmp/kafka-logs" para "/home/pc/kafka/data/kafka".

  g. Finalmente, em terminais diferentes, foram rodados os comandos para iniciar o servidor Zookeeper "zookeeper-server-start.sh /home/pc/kafka/config/zookeeper.properties" e Kafka "kafka-server-start.sh server.properties". No caso do segundo, visto que já se encontrava na pasta "~/kafka/config", não foi necessário colocar todo o diretório no comando.

  h. Foi então criado o tópico com o mesmo nome do tópico feito para a parte principal da atividade, com "kafka-topics.sh --bootstrap-server localhost:9092 --create --topic trabalhokafka", para acrescentar especificações adicionais, como o número de partições, é necessário colocar isso no final do comando, como com "--partitions 3".

2. Após toda a preparação inicial, é possível iniciar a instalação do Conduktor em si.

  a. Para instalar o Conduktor no Linux Ubuntu, foi necessário realizar uma configuração adicional. No site "https://www.conduktor.io/get-started/#desktop" foi selecionada a versão para Linux, escolhendo o diretório Flatpack.

  b. No site do Flathub, foi procurado o setup inicial que deve ser feito para a utilização dessa plataforma com Ubuntu. Então, foi rodado o comando "sudo apt install flatpak" e "sudo apt install gnome-software-plugin-flatpak", possibilitando a instalação de aplicativos sem a necessidade da utilização da linha de comando. Depois, foi rodado o comando para adicionar o repositório Flathub "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo". O sistema então foi reiniciado e o Conduktor foi instalado.

![github-small](https://i.imgur.com/qy3UxM2.png)

3. Após a inicialização da aplicação, é necessário fazer a conexão do Cluster.

![github-small](https://i.imgur.com/W5EUBrB.png)

  a. Foram indicados o nome e o Boostrap Server (localhost:9092) e depois a conexão foi testada.

![github-small](https://i.imgur.com/IljkKnO.png)
Sucesso!

  Já é possível acessar a interface do programa.

![github-small](https://i.imgur.com/XiAPQ8D.png)

![github-small](https://i.imgur.com/6BfjDqE.png)

  Com o Conduktor, é posível produzir e consumir, ver os tópicos, partições, brokers, entre outras funcionalidades.

  b. Foram então produzidas mensagens para o tópico criado anteriormente, "trabalhokafka". Para isso, é necessário clicar no botão "+ producer". Após a seleção do tópico, pode-se indicar se a mensagem enviada será composta por informações aleatórias, o que foi feito para testar o funcionamento do programa.

![github-small](https://i.imgur.com/Q7rInDH.png)

  Além disso, pode-se ver as mensagens que estão sendo enviadas em tempo real clicando no botão "+ consumer". Como a imagem abaixo mostra, as mensagens que irão aparecer serão as novas (mas isso pode ser definido), enviadas ao tópico "trabalhokafka".

![github-small](https://i.imgur.com/LCUHjhO.png)

  É possível observar que a mesma quantidade de mensagens enviadas foi recebida, conforme o esperado.

![github-small](https://i.imgur.com/KofWrYx.png)

  Ademais, ao conferir as mensagens enviadas por meio do terminal, o que foi enviado com o uso do Conduktor se encontrava lá.

<h1 align="center"><<<<< Extra) Prints >>>>></h1>
1. Link com doc contendo todos os prints: https://docs.google.com/document/d/1wzWXKQfqRpkoEAzRXUPapPnh7vAYYZcIbqbEk6l2B7U/edit?usp=sharing


<h1 align="center"><<<<< Extra) Observação >>>>></h1>
1. É necessário ter java instalado. O comando utilizado foi "sudo apt-get install default-jre".

