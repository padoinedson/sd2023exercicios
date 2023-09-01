
#



# <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>


Criar um arquivo docker-compose.yml contendo

>   
>  


Abrir um terminal e entrar no local onde está o arquivo `docker-compose`


$ cd exercicio8

$ sudo docker-compose up 

> use -d para backgroud



Em outro terminal:  


$ sudo docker ps  
> tem dois containers rodando  
> um do bd e outro do wordpress


### Abrir um browser e testar  

http://localhost:8000/

