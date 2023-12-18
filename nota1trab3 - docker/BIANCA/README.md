# PHP

# INSTALAÇÃO NO HOST 

## Instalação do Servidor NODE

### Instalar o NODE
    $ sudo apt install node

### Instalar o DockerCompose
    $ sudo apt install docker-compose

### Verificação do status do serviço NODE
    $ sudo systemctl status node

## INSTALAÇÃO EM CONTAINER 

### DOCKER RUN

Baixar a imagem NODE

    # sudo docker pull node

Criar e executar o Container

    $ sudo docker run -it node /bin/bash

![docker1](/DOCKER/docker1.jpg)

# INSTALAÇÃO DO CONTAINER COM DOCKER FILE

Criar um arquivo com o nome Dockerfile, contendo:

![docker2](/DOCKER/docker2.jpg)


Vamos executar o arquivo Dockerfile

    $ sudo docker build -t nodejs-bianca:1.0.0 -f Dockerfile .

![docker3](/DOCKER/docker3.jpg)

Agora vamos testar o container 

    $ node

![docker4](/DOCKER/docker4.jpg)

# INSTALAÇÃO DO CONTAINER COM DOCKER COMPOSE

Criar um arquivo com o nome docker-compose.yaml, contendo:

![docker5](/DOCKER/docker5.jpg)

Vamo executar o arquivo docker-compose.yaml

    $ sudo docker-compose up -d

![docker6](/DOCKER/docker6.jpg)

Vamos verificar a quantidade de Containers que estão rodando

    $ sudo docker ps
    $ sudo docker exect -it biancajs-node node -e "console.log(12+13)"

![docker7](/DOCKER/docker7.jpg)



