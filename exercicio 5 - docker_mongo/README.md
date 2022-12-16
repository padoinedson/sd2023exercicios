
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



# <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>




Criar um arquivo docker-compose.yml contendo

>   
>  


Abrir um terminal e entrar no local onde está o arquivo `docker-compose`


$ sudo docker-compose up  


Em outro terminal:  


$ sudo docker ps  

$ sudo docker exec -it mongodb2023docker bash  

$ sudo docker stop mongodb2023docker

$ sudo docker rm mongodb2023docker