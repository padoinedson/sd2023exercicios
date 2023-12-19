# Mosquitto

## Instalação no Host

Atualize od pacotes:
```bash
$ sudo apt update
```

Instale o Mosquitto:
```bash
$ sudo apt install mosquito mosquitto-clients
```

Inicie o serviço Mosquitto:
```bash
$ sudo service mosquitto start
```

Verifique o status do serviço Mosquitto:
```bash
$ sudo service mosquitto status
```

## Instalação com Dockerfile

Através de um editor de texto, adicione o seguinte trecho ao arquivo Dockerfile:
```dockerfile
FROM eclipse-mosquitto:latest
```

Construir a imagem a partir do Dockerfile:
```bash
$ sudo docker build -t meu-mosquitto-image .
```

Criar e iniciar um container: 
```bash
$ sudo docker run -d --name meu-mosquitto-container -p 1883:1883 -p 9001:9001 meu-mosquitto-image
```

Verifique se o container está ativo: 
```bash
$ sudo docker ps
```

## Instalação com Docker-Compose 

Através de um editor de texto, crie e adicione o seguinte trecho ao arquivo docker-compose.yml:
```yml
version: '3'

services:
  mosquitto:
    image: eclipse-mosquitto:latest
    ports:
      - "1883:1883"
      - "9001:9001"
```

Execute o container:
```bash
$ sudo docker-compose up -d
```

Verifique se o container está ativo: 
```bash
$ sudo docker ps
```

## Testando o Serviço

Com o container ja ativo:

Abra um terminal e execute: 
```bash
$ sudo docker exec -it meu-mosquitto-container mosquitto_sub -h localhost -t teste
```

Abra um segundo terminal e execute: 
```bash
$ sudo docker exec -it meu-mosquitto-container mosquitto_pub -h localhost -t teste -m "Olá, Mosquitto!"
```

