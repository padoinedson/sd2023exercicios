

## Atividade 14 ---- docker com nginx


## Atividade 14.1 - colocar o servidor no ar

### executar o container  
	$ sudo docker run nginx   

### executar o container com nome   
	$ sudo docker run --name nginx nginx   

### executar o container com nome e com porta   

	$ sudo docker run --name nginx -p 8080:80 nginx  

### executar o container com nome e com porta removendo anteriores
	$ sudo docker run --rm --name nginx -p 8080:80 nginx

### testar  
> a) no browser digite:  
	localhost:8080  





## Atividade 14.2 - atualizar a página web

$ sudo docker exec -it nginx bash

> dentro do container:

$	cd /usr/share/nginx/html/    
$	apt update   
$	apt install nano   
$	nano index.html  
>		altualizar o arquivo  


### testar   
> a) no browser digite:  
	localhost:8080  
ou  
> b) em outro terminal digite:  
	$ lynx localhost:8080  



## Atividade 14.3 - atualizar a página web

### executar o container com nome e com porta removendo anteriores, com volume/compartilhando a pasta  

	$ mkdir www  

	$ sudo docker run --rm --name nginx -p 8080:80 -v ~/www:/usr/share/nginx/html nginx  

	$ cd www   

	$ nano index.html  
>						  <!DOCTYPE html>
>							<html>
>							<head>
>							<title> SD - testando!</title>
>							</head>
>							<body>
>							<h1>testando!</h1>
>							</body>
>							</html>

### testar   
> a) no browser digite:  
	localhost:8080  
ou  
> b) em outro terminal digite:  
	$ lynx localhost:8080  




#### criar uma imagem 

	$ vi Dockerfile

>					FROM nginx 
>					RUN apt update && apt install -y vim  
>					COPY www/index.html /usr/share/nginx/html  


#### criar um container com a minha imagem 

	$ docker pull nginx  

	$ docker build -t nginxpadoin:latest .   


#### rodar o container

	$ docker run --rm --name nginx -p 8080:80  nginxpadoin:latest  
