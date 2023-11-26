Tomcat
https://hub.docker.com/_/tomcat

Host Install

Usar o seguinte comando para atualizar os componentes disponíveis para a instalação
$ sudo apt update

Buscar qual a versão mais nova disponível do tomcat (no meu caso era a 10)
$ sudo apt search tomcat

Instalar a versão mais nova
$ sudo apt install tomcat10

Em seguida abrir um navegador em “localhost:8080” para conferir se o tomcat está funcionando

Caso não esteja é possível ativá-lo pelo comando
$ sudo systemctl enable tomcat10

Caso deseje também é possível desativá-lo por meio do comando
$ sudo systemctl disable tomcat10

Container Install

Usar esse comando para instalar o docker em seu sistema
$sudo apt install docker.io

Procurar pela imagem do tomcat
$ sudo docker search tomcat

Baixar a imagem para seu sistema
$ sudo docker pull tomcat

Conferir se foi baixado corretamente
$ sudo docker images

Rodar um container com um nome especifico (nesse caso tomc)
$ sudo docker run -d --name tomc tomcat

Verificar se o container foi inicializado
$ sudo docker ps

Docker-compose Install

Instalar docker-compose
$ sudo apt install docker-compose
Criar um arquivo docker-compose.yml na pasta atual com o seguinte conteúdo
version: '3.3'
services:
  web:
    image: tomcat
    ports:
      - "8081:8080"
    volumes:
      - ./index.html:/usr/local/tomcat/webapps/test/index.html


Levantar o docker
$ sudo docker-compose up

Teste
Para testar qualquer dos serviços instalados acima basta entrar em seu navegador e ir para localhost:8080 ou a porta na qual o serviço estiver rodando
