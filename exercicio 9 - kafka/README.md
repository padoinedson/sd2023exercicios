 


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


### Rodar o compose   (terminal 1)  
> entrar na pasta que está o arquivo "docker-compose.yml"  

$ sudo docker-compose up   
> -d datached  


### Verificar o status   (terminal 2)  
$ sudo docker-compose ps  





## << TOPICOS >>  

### Acessar um dos containers  (terminal 3)    
$ sudo docker exec -it kafka4_kafka-1_1 bash  

### Criar um tópico  
$ kafka-topics --create --bootstrap-server localhost:29092 --replication-factor 3 --partitions 3 --topic calor  

### Listar todos os tópicos criados  
$ kafka-topics --list --bootstrap-server localhost:29092  

### Informações de um tópico  
$ kafka-topics --describe --bootstrap-server localhost:29092 --topic calor  





## << PRODUTOR >>  

### Acessar um dos containers  (terminal 4)    
$ sudo docker exec -it kafka4_kafka-1_1 bash  

### Post no broker  
$ kafka-console-producer --broker-list localhost:29092 --topic calor  
> ctrl+c para sair do console  





# << CONSUMIDOR >>  

### Acessar um dos containers  (terminal 5)    
$ sudo docker exec -it kafka4_kafka-1_1 bash  
 
### Get no broker - receber novas inserções
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor
> ctrl+c para sair do console  

### Get no broker - receber todas as inserções  
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning  

### Get no broker - receber todas as inserções de um grupo  
$ kafka-console-consumer --bootstrap-server localhost:29092 --topic calor --from-beginning --group sala  



