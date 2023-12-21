## Instalação
```sh
sudo apt install docker
sudo apt install docker.io
sudo apt install docker-compose
```
## Docker run
baixar e rodar a imagem eclipse-mosquitto:
```sh
sudo docker pull eclipse-mosquitto
sudo docker run -it eclipse-mosquitto
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186584459651317760/dockerRun.png?ex=6593c7e4&is=658152e4&hm=e58daa0c6f209983e1c48608741d7e5d11b65a930867ff0317a3749637937627&=&format=webp&quality=lossless)
## Dockerfile
crie um arquivo chamado `Dockerfile`.
```sh
FROM ubuntu
MAINTAINER nome
RUN apt-get -y update
ENV apt-get -y eclipse-mosquitto
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186584459227713626/dockerfile.png?ex=6593c7e4&is=658152e4&hm=810ddf7628bd700d73e8cbbcfbb787c96c0b471e427d16261d991a006ffc5ab5&=&format=webp&quality=lossless)
```sh
sudo docker build -t mqtt:1.0.0 -f dockerfile .
sudo docker run -it mqtt:1.0.0
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186584458405609524/dockerBuild.png?ex=6593c7e4&is=658152e4&hm=c53c96f78a28cd5c873437cf7fe34da862a3901206c3cf2605881c264f43c4df&=&format=webp&quality=lossless)
## Docker compose
crie um arquivo chamado `docker-compose.yml`.
```sh
version: '3.7'
services:
  mosquitto:
    image: eclipse-mosquitto
    container_name: mosquitto
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186584458116223026/dcyaml.png?ex=6593c7e4&is=658152e4&hm=57583aa283835b2c8ee419c73c21abf9258d470e9056b56a65104c7c51e7f7b1&=&format=webp&quality=lossless)
```sh
sudo docker-compose up -d
```
executar comandos direto no container:
```sh
sudo docker exec -it mosquitto mosquitto -v
```
![Instalação](https://media.discordapp.net/attachments/848753904405446687/1186584458716000316/dockerCompose.png?ex=6593c7e4&is=658152e4&hm=5e4ce21e0e55bdf6840a101a8bbd127057ec60933184fae49011db0155c1a1ac&=&format=webp&quality=lossless)