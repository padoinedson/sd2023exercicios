# INSTALAÇÃO DO MONGO

## Instalação do serviço MongoDB
### Instalar o serviço MongoDB no host.
	$ sudo apt install mongodb
	
### Instalar o Docker Compose (necessário para a última maneira de instalar)
    $ sudo apt install docker-compose

### Verificação do status do serviço Mongo
    $ sudo systemctl status node

## INSTALAÇÃO EM CONTAINER 

### DOCKER RUN

Baixar a imagem MONGO

    # sudo docker pull mongo

Criar e executar o Container

    $ sudo docker run -it mongo /bin/bash

# INSTALAÇÃO DO CONTAINER COM DOCKER FILE

Criar um arquivo com o nome Dockerfile, contendo:

    # puxa a ultima imagem do mongo
    FROM mongo:latest
    
    # maintainer
    
    LABEL maintainer="Victor"
    
    # expor a port do servidor
    
    EXPOSE 27017
    
    # iniciar o mongo
    
    CMD ["mongod"]

Vamos executar o arquivo Dockerfile

    $ sudo docker build -t mongodb-victor:latest -f Dockerfile .

Agora vamos testar o container 

    $ mongod

# INSTALAÇÃO DO CONTAINER COM DOCKER COMPOSE

Criar um arquivo com o nome docker-compose.yaml, contendo:

    version: '3'
    
    services:
      mongodb:
        image: mongo:latest
        container_name: victor-mongodb
        ports:
          - "27017:27017"
        restart: always
        environment:
          MONGO_INITDB_ROOT_USERNAME: root
          MONGO_INITDB_ROOT_PASSWORD: root
        labels:
          maintainer: "Victor"

Vamos executar o arquivo docker-compose.yaml

    $ sudo docker-compose up -d

Rodar um comando dentro do container

    $ sudo docker ps
    $ sudo docker exec -it victor-mongodb mongod db
