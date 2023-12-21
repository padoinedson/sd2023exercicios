Gabriel Burmann

### Serviço utilizado:
```
https://hub.docker.com/_/elixir
```

### Instalação no Host
### Atualize os componentes:
```
sudo apt update
sudo apt install elixir
```
<img src="./img/elixir.png">
###Iniciar o serviço:

```
sudo service elixir start
```

### Instalação Docker

`sudo docker install docker.io`

`sudo docker search elixir`

`sudo docker pull elixir`

<img src="./img/pull.png">

`sudo docker images`

`sudo docker run -d --name elixir elixir`

`sudo docker ps`

<img src="./img/docker-ps.png">

### Docker-compose

`sudo apt install docker-compose`

### Crie um arquivo chamado docker-compose.yml com o seguinte conteúdo:
```
version: '3'
services:
  elixir:
    image: elixir
    ports:
      - "8090:8086"
```
<img src="./img/docker-compose.png">
### Executar com Docker Compose
```
docker-compose up -d
```
<img src="./img/up.png">
