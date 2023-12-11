# ATIVIDADE DOCKER UTILIZANDO SQLite3
Para esse trabalho foi necessário escolher um serviço, escolhi utilizar um banco de dados chamado SQLite3. Comecei rodando o comando para instalação do mesmo. 
**sudo apt install sqlite3**

Após realizar a instalação do banco de dados, realizei a instalação do docker.io
**sudo apt install docker.io**

Criei um diretório para o trabalho e naveguei para o mesmo.
**mkdir dockertrab**
**cd dockertrab/**

Criei um Script SQL que definiu uma tabela chamada "brasileirao" contendo 3 colunas 'id', 'time' e 'titulos'. Inseri alguns dados nela, foi preciso criar um arquivo com o nome "*script.sql*" dentro desse script tinha os seguintes comandos para que a tabela com as informações citadas acima fossem criadas.
-- script.sql
-- Criação de uma tabela de exemplo
**CREATE TABLE brasileirao (**
   **id INTEGER PRIMARY KEY,**
   **time TEXT,**
    **titulo INTEGER**
**);**
-- Inserção de dados na tabela
**INSERT INTO brasileirao (time, titulo) VALUES ('Internacional', 55), ('Gremio', 30);**
![script](https://github.com/padoinedson/sd2023exercicios/assets/141967871/5cd72540-865f-4a2e-b422-47890ceeb1ca)


Foi preciso criar outro arquivo, denominado de Dockerfile, usado para criar uma imagem Docker que inclua o SQLite e também um script SQL para inicializar o banco de dados quando um conteiner baseado nessa imagem for iniciado. Nesse Dockerfile estou usando uma imagem Alpine Linux que é uma distribuição linux de tamanho compacto. Inclui também um comando que instala o SQLite no sistema de arquivos da imagem Alpine no cache, economizando assim espaço na imagem. Por ultimo o comando copia um script SQL chamado script.sql para o diretório \docker-entrypoint-initdb.d/ na imagem, é um local especifico que deve ser executado durante a incialização do banco de dados. Dentro do dockerfile tinha as seguintes informações:
**FROM alpine:latest**
**RUN apk --no-cache add sqlite**
**COPY script.sql /docker-entrypoint-initdb.d/**
![dockerfile](https://github.com/padoinedson/sd2023exercicios/assets/141967871/c2dcd149-7ccb-4f9b-80fe-35f6d31fda7d)

Outro arquivo criado foi o docker-compose.yml contendo algumas configurações assim como os outros arquivos criados anteriormente, primeiro realizei a instalação do docker-compose e depois realizei a criação do arquivo. Segue os comando utlilzados e o arquivo do docker-compose
**sudo apt install docker-compose**
FOTO DO ARQUIVO DOCKER-COMPOSE
![arquivo docker-compose](https://github.com/padoinedson/sd2023exercicios/assets/141967871/3b333e0e-d65c-4e9a-bb57-44b0c5ae12ca)
Para iniciar o serviço é usado o comando listado a baixo, ele inicia o serviço conforme definido no arquivo docker-compose.yml.
**sudo docker-compose up**

Realizado esses passos comecei a construção da imagem do Docker, denominei a imagem de 'meu_banco' usando o conteiner base do Alpine e também foi feito a instalação do SQLite.
**sudo docker build -t meu_banco:latest .**

Após criado a imagem, realizei a execução do conteiner, atribui o nome de 'meu_container' e montei o diretório atual dentro do conteiner.
**sudo docker run -it --name meu_container -v $PWD:/dados meu_banco**

Copie o script SQL para o conteiner.
**sudo docker cp script.sql meu_container:/dados/script.sql**

Após copiado o script para o conteiner, acessei o console do SQLite e realizei a execução do script.
***sudo docker exec -it meu_container sqlite3 /dados/meu_banco.db**

Realizei uma consulta das tabelas que continham, para verificar se a que foi criado anteriormente tinha dado certo, mostrando então que a tabela brasileirao tinha sido criada.
**.tables**

Por ultimo rodei o comando para exibir os dados inseridos na tabela.
**SELECT * FROM brasileirao;**

![banco de dados](https://github.com/padoinedson/sd2023exercicios/assets/141967871/ca780bfa-21ff-423e-887b-5e52f938e047)


# CRIAÇÃO DO CONTAINER UTILIZANDO O DOCKER RUN
![DOCKER RUN](https://github.com/padoinedson/sd2023exercicios/assets/141967871/3354a621-d3e0-4add-a28f-b3ae5b815086)

# CRIAÇÃO DO CONTAINER UTILIZANDO O DOCKERFILE
![comando dockerfile](https://github.com/padoinedson/sd2023exercicios/assets/141967871/28e9ff4e-dc2e-494b-be52-0bec681db4f3)

# CRIAÇÃO DO CONTAINER UTILIZANDO O DOCKER-COMPOSE
![comando docker-compose](https://github.com/padoinedson/sd2023exercicios/assets/141967871/d982c4f6-cf8c-4d75-9a42-85326c819ec9)

# EXECUTANDO O SERVIÇO FORA DO CONTAINER 
![tabelas banco de dados](https://github.com/padoinedson/sd2023exercicios/assets/141967871/d60c9ffb-6a5e-4e8f-8b5f-f4baedb3c97a)