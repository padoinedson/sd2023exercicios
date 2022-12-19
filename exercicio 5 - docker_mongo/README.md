
# mysql


# <<<<< INSTALAÇÃO NO HOST >>>>>


$ sudo apt install mongodb


$ mongo

### Lista bancos criados: 
> show databases;

### Selecionar banco
Ex. use <nomedobanco>;
> use sd2023;




### Listar collections
> show collections;

### Listar dados de uma collection
Ex.db.<nomecollection>.find();
> db.alunos.find();




### Inserir um item   
> db.alunos.insert({ nome: "Luiz", idade: 29 });
> db.alunos.find().pretty();

### Atualizar um item   
> db.alunos.update({nome: "Luiz"}, {nome: "Luiz", idade: 29, uf: "RS"})
> db.alunos.find().pretty();

### Inserir um item   
> db.alunos.insert({ nome: "Carlos", idade: 30 });  
> db.alunos.find().pretty();  

### Deletar um item   
> db.alunos.deleteOne({nome: "Luiz"})  
> db.alunos.find().pretty();  


> exit




# <<<<< INSTALAÇÃO EM CONTAINER >>>>>


$ sudo docker search mongo  

$ sudo docker images

$ sudo docker pull mongo

$ sudo docker images

$ sudo docker run -d  --name mongosd2023 mongo 

$ sudo docker ps 

$ sudo docker exec -it mongosd2023 bash

	> $ mongod --version  
	> $ mongosh  
	> exit    
	> exit  

$ sudo docker stop mongosd2023

$ sudo docker rm mongosd2023





# <<<<< INSTALAÇÃO EM CONTAINER com volume >>>>>


## criação da pasta no host
$ cd ~

$ mkdir -pv mongodb/database

		> -p parent directory  
		> -v verbose  

$ ls -l  
$ ls -l mongodb  
 


## criação do container 1


$ sudo docker run -d  --name mongosd2023 -v /home/padoin/mongodb/database:/data/db     mongo 

		> -d detached  
		> --name nome do container   
		> -v volume  



$ sudo docker ps


$ sudo docker exec -it mongosd2023 bash

#mongosh

	>  use comida  
	comida>  db.createCollection("frutas")  
	comida>  show dbs     
	comida>  db.frutas.insertMany([ {name: "maça", type: "verde", price: 1.5}, {name: "laranja", type: "ceu", price: 2.3} ])
	comida> db.frutas.find().pretty()  
	comida> exit

#exit



$ sudo docker stop mongosd2023

$ sudo docker rm mongosd2023




## criação do container 2

> a pasta /home/padoin/mongodb/database ainda permanece no sistema  
> vamos criar outro container com outro mongodb  
> os dados estaõ lá salvos   

$ sudo docker run -d  --name mongotest2 -v /home/padoin/mongodb/database:/data/db     mongo 

$ sudo docker exec -it mongotest2 bash


#mongosh

	>  use comida  
	comida>  show dbs     
	comida> db.frutas.find().pretty()  
	comida>  db.frutas.insertMany([ {name: "pera", type: "verde", price: 0.5}, {name: "mamao", type: "papaia", price: 1.3} ])
	comida> db.frutas.find().pretty()  	
	comida> exit

#exit



$ sudo docker stop mongotest2

$ sudo docker rm mongotest2


## exclusão da pasta no host

$ cd ~

$ rm -rf mongodb/database

		> -recursive  
		> -f force  






# <<<<< INSTALAÇÃO EM CONTAINER com volume >>>>>



## Criação de um volume  

> Criar um volume para armazenar os dados do banco    
> nome do volume: mysql2023data    

$ docker volume create mysql2023data   




## Criar um container com o volume  

$ sudo docker run -d  --name mongotest3 -v mysql2023data:/data/db     mongo  

> agora quando o container for removido os dados ficam salvos no volume   



 








####  Analisar:  
$ docker run -d -p 27017:27017 --name mongo2023test -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=mongo2023admin mongo:latest















# <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>


## Criar um arquivo docker-compose.yml contendo

>  
>  


 Abrir um terminal 

 entrar no local onde está o arquivo `docker-compose`

## Rodar o compose

$ sudo docker-compose up  


## Acessar o container :  

> Abrir outro terminal  

$ sudo docker ps  

$ sudo docker exec -it mongodb2023docker bash  

$ sudo docker stop mongodb2023docker

$ sudo docker rm mongodb2023docker


#### Analisar:  

$ mongo --host 172.1.1.1 --port 27017