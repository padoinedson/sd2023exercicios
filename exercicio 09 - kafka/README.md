
## <<<<<<<<<<<<<<< Instalação com docker-compose >>>>>>>>>>>>>>>>>>>


### Acessar
https://github.com/confluentinc/cp-docker-images/tree/5.3.3-post/examples  
https://github.com/confluentinc/cp-docker-images/tree/5.3.3-post/examples/kafka-cluster

> copiar o arquivo: "docker-compose.yml" do kafka cluster 

> neste exemplo temos:    
> máquinas = 3  
> broquer = 3  
> partição = 3  
> réplicads = 3




## Rodar screen
### no Terminal 1:

		$ screen



## Atividade 1 ---- INSTALAÇÃO 

## Rodar o compose  
### no Terminal 1:  


		$ sudo docker-compose up   

> entrar na pasta que está o arquivo "docker-compose.yml"  
> usar -d para rodar em backgroud  


## Atividade 1.1 ---- GERENCIAMENTO 

## Verificar o status   
### no Terminal 2:  
		$ sudo docker-compose ps  
		ou
		$ sudo docker ps  




# Atividade 2 ---- UTILIZAÇÃO 

## Criar Tópico  
### no Terminal 3:  

### Acessar um dos containers  

		$ sudo docker exec -it padoin_kafka-1_1 bash  

### Criar um tópico  
		$ kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic calor  

### Listar todos os tópicos criados  	
		$ kafka-topics --list --bootstrap-server localhost:29092  

### Informações de um tópico  
		$ kafka-topics --describe --bootstrap-server localhost:29092 --topic calor  




## Enviar eventos no tópico << PRODUTOR >> 
### no Terminal 4:
 

### Acessar um dos containers      
		$ sudo docker exec -it padoin_kafka-1_1 bash  

### Post no broker  
		$ kafka-console-producer --broker-list localhost:29092 --topic calor  
> ctrl+c para sair do console  





## Ler os eventos armazenados no tópico << CONSUMIDOR >>  
### no Terminal 5:



### Acessar um dos containers      
		$ sudo docker exec -it padoin_kafka-1_1 bash  
 
### Get no broker - receber novas inserções
		$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor

> ctrl+c para sair do console  

### Get no broker - receber todas as inserções  
		$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning  
> ctrl+c para sair do console  

### Get no broker - receber todas as inserções de um grupo  
		$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning --group sala

> ctrl+c para sair do console  



## Parar o KAFKA 

### no Terminal 5:

>		CTRL C para sair do console  
		$ exit para sair do container  
		$ exit para fechar o terminal do screen  


### no Terminal 4:

>		CTRL C para sair do console  
		$ exit para sair do container  
		$ exit para fechar o terminal do screen  

### no Terminal 3:

		$ exit para sair do container  
		$ sudo docker-compose down para encerrar os containers criados  
		$ exit para fechar o terminal do screen  


### no Terminal 2:

		$ exit para fechar o terminal do screen  



