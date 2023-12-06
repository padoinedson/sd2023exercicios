HOST:

1º Instale a versão 3.9 do Python, utilizando o comando:  sudo apt-get install python3.9

2º Crie um arquivo chamado “TrabDocker.py”. No interior deve conter o código: print(`Hello World`)

3º Para imprimir o conteúdo do arquivo, usar o comando:  python3 TrabDocker.py

DOCKER RUN

1º Faça o download  da imagem oficial do Python na versão 3.9, com o comando: sudo docker pull python:3.9

2º Para listar os contêineres do sistema, estando em execução ou parados, utilize: sudo docker ps-a

3º Crie um contêiner interativo usando a imagem do Python, por meio do comando:  sudo docker run -it python /bin/bash

4º Dentro do contêiner, solicite a linguagem para realizar o teste: python

DOCKERFILE

1º Crie um arquivo contendo as informações da imagem e nomeio-o como  “Dockerfile”

2º Para criar uma imagem Docker denominada “python3” com a tag 1.0.0 usando as informações criadas no arquivo “Dockerfile”, utilize: sudo docker build -t python3:1.0.0 -f Dockerfile

3º Exiba uma lista das imagens Docker disponíveis, com o comando:  sudo docker images

4º Para criar um contêiner interativo utilizando a imagem criada, use o comando:  sudo docker run -it python3:1.0.0 /bin/bash

5º Realize o teste solicitando a linguagem

DOCKER-COMPOSE

1º Crie um arquivo contendo as informações desejadas e nomeio-o como “docker-compose.yaml”

2º Inicie os serviços definidos no arquivo “ docker-compose.yaml”, por meio do comando: sudo docker-compose up -d

3º Exiba informações sobre os contêineres em execução com: sudo docker ps

4º Execute um shell Bash dentro do contêiner para torná-lo interativo, via comando: sudo docker exec -it composePython bash

5º Para confirmar o funcionamento, solicite a linguagem


