

# mysql


# <<<<< INSTALAÇÃO NO HOST >>>>>


## Instalação do servidor MySQL

$ sudo apt install mysql-server  

$ mysql --version  

$ sudo systemctl status mysql  




## Configuração do MySQL

$ sudo mysql


		mysql> SHOW DATABASES;

		mysql> CREATE DATABASE SD2023; 

		mysql> SHOW DATABASES;


		mysql> CREATE USER 'padoin'@'localhost' IDENTIFIED BY 'padoin123';

		mysql> select host, user from mysql.user;

		mysql> GRANT ALL PRIVILEGES ON SD2023.* TO 'padoin'@'localhost';  

		mysql> FLUSH PRIVILEGES;  

		mysql> exit  



## Acessando o Banco

$ mysql -u padoin -p

		mysql> SHOW DATABASES; 

		mysql> USE SD2023;

		mysql> CREATE TABLE alunos(cod int NOT NULL, nome VARCHAR(30) NOT NULL,PRIMARY KEY(cod));

		mysql> DESCRIBE alunos;

		mysql> INSERT INTO alunos VALUE (2019, "Anna");  
		mysql> INSERT INTO alunos VALUE (2023, "Paulo");

		mysql> SELECT * FROM alunos;

		mysql> exit  










# <<<<< INSTALAÇÃO EM CONTAINER >>>>>


## Criação da imagem


Criar um arquivo Dockerfile contendo

$ nano Dockerfile

> 		FROM mysql  
> 		MAINTAINER padoin  



Abrir um terminal e entrar no local onde está o arquivo `Dockerfile`

$ sudo docker build -t mysql2023 .   

> caminho/diretorio atual: "."   
> nome da imagem crida: "mysql2023" 


### Exibir imagens locais  

$ sudo docker images  


### Inspecionar imagem  

$ sudo docker image inspect mysql2023



## Criar um container 

$ screen 

$ sudo docker run --name mysql2023docker -e MYSQL_ROOT_PASSWORD=1234 mysql2023

> nome do conatiner: mysql2023docker  
> imagem usada: mysql2023   
> senha do mysql: 1234  






## Check o container em execução
> CTRL a c - abrir outro terminal


$ sudo docker top mysql2023docker  

$ sudo docker logs mysql2023docker  


## Acessar o container

> CTRL a c - abrir outro terminal  

$ sudo docker exec -it mysql2023docker bash



## Acessando o MySQL 

$ mysql -u root -p

> senha: 1234 
		mysql> SHOW DATABASES; 

		mysql> CREATE DATABASE SD2023;  
		mysql> show databases;  
		mysql> exit  


## Sair do container

$ exit


## Parar o container

$ sudo docker ps  

$ sudo docker stop mysql2023docker  

$ sudo docker ps  












# <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>

## Instalação

$ sudo apt install docker-compose


## Configuração do arquivo docker-compose 

Criar o arquivo docker-compose.yml com o conteúdo:

		version: '3'
		services:
		  db:
		    image: mysql:5.7
		    container_name: mysql2023docker
		#    ports:
		#      - 13306:3306
		#    volumes: 
		#      - ./init.sql:/data/application/init.sql
		    environment: 
		      MYSQL_ROOT_PASSWORD: 1234
		  



## Executar os containers 

> Abrir um terminal e entrar no local onde está o arquivo `docker-compose`


> Opção 1  

$ screen  
$ sudo docker-compose up 

> Opção 2  
> -d para rodar em backgroud

$ sudo docker-compose up -d 



## Acessar o container
> CTRL a c - abrir outro terminal


$ sudo docker ps  

$ sudo docker exec -it mysql2023docker bash





## Acessando o MySQL 

$ mysql -u root -p

> senha: 1234 

		mysql> SHOW DATABASES; 

		mysql> CREATE DATABASE SD2023;  
		mysql> show databases;  
		mysql> exit  


## Sair do container

$ exit




## Parar os containers

$ sudo docker-compose down