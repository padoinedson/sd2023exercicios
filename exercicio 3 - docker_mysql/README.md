

 


# <<<<< INSTALAÇÃO NO HOST >>>>>


## Instalação do servidor MySQL

$ sudo apt install mysql-server  

$ mysql --version  

$ sudo systemctl status mysql  
> digite "q" para sair



## Configuração do MySQL

$ sudo mysql

mysql> CREATE USER 'padoin'@'localhost' IDENTIFIED BY 'padoin123';  
mysql> GRANT ALL PRIVILEGES ON *.* TO 'padoin'@'localhost' WITH GRANT OPTION;  
mysql> FLUSH PRIVILEGES;  
mysql> exit  



## Acessando o MySQL

$ mysql -u padoin -p

mysql> CREATE DATABASE SD2023;  
mysql> show databases;  
mysql> exit  










# <<<<< INSTALAÇÃO EM CONTAINER >>>>>


## Criação da imagem


Criar um arquivo Dockerfile contendo

> FROM mysql  
> MAINTAINER padoin  


Abrir um terminal e entrar no local onde está o arquivo `Dockerfile`

$ sudo docker build -t mysql2023 .   
> . significa o diretorio local  
> nome da imagem crida: mysql2023    


### Exibir imagens locais  

$ sudo docker images  


### Inspecionar imagem  

$ sudo docker image inspect mysql2023



## Criar um container 


$ sudo docker run --name mysql2023docker -e MYSQL_ROOT_PASSWORD=1234 mysql2023

> nome do conatiner: mysql2023docker  
> imagem usada: mysql2023   
> senha do mysql: 1234  





Abrir outro terminal

## Check o container em execução

> sudo docker top mysql2023docker  

> sudo docker logs mysql2023docker  


## Entrar no container

$ sudo docker exec -it mysql2023docker bash



## Acessando o MySQL 

$ mysql -u root -p

> senha: 1234 

mysql> CREATE DATABASE SD2023;  
mysql> show databases;  
mysql> exit  


## Sair do container

$ exit


## Parar o container

$ sudo docker ps  
$ sudo docker stop mysql2023docker  










# <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>


Criar um arquivo docker-compose.yml contendo

>   
>  


Abrir um terminal e entrar no local onde está o arquivo `docker-compose`


$ docker-compose up 

> use -d para backgroud




