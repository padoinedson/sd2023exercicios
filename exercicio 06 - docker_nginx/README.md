

## Atividade 1 ---- docker com nginx


	$ sudo apt install screen  

	$ sudo apt install lynx

	$ screen


## Atividade 1.1 - colocar um servidor nginx no ar


	$ sudo docker search nginx

	$ sudo docker pull nginx

	$ sudo docker images


### opção 1 - criar um container  
	$ sudo docker run nginx   
 
### opção 2 - executar o container com nome   
	$ sudo docker run --name nginxpadoin nginx   

### opção 3 - executar o container com nome e com porta   
	$ sudo docker run --name nginxpadoin -p 8080:80 nginx  
 
### opção 4 - executar o container com nome e com porta removendo anteriores
	$ sudo docker run --rm --name nginxpadoin -p 8080:80 nginx



### testando

> opção 1 - sem interface gráfica  

	$ CTRL a c --- criar um novo shell no screen  
	$ lynx localhost:8080  

> opção 2 - com interface gráfica - no browser digite

	localhost:8080  




## Atividade 1.2 - atualizar a página web no container

	$ CTRL a c --- criar um novo shell no screen 
	
	$ sudo docker exec -it nginxpadoin bash

> dentro do container:

	$	apt update   
	$	apt install nano   
	$	cd /usr/share/nginx/html/    
	$	ls 
	$	nano index.html  
>		altualizar e salvar o arquivo  


### testar   

> opção 1 - sem interface gráfica  

	$ CTRL a c --- criar um novo shell no screen  
	$ lynx localhost:8080  

> opção 2 - com interface gráfica - no browser digite

	localhost:8080  


### fechar os terminais do screen	
	$ exit  --- sair do screen 2
	$ exit  --- sair do screen 1 
### encerrar o container do nginx  	
	$ CTRL C --- encerrar o nginx  






## Atividade 1.3 - atualizar a página web no home

### executar o container com nome e com porta removendo anteriores, com volume, compartilhando a pasta  

> no home - terminal 0  
	$ cd ~  
	$ mkdir www    

	$ sudo docker run --rm --name nginxpadoin -p 8080:80 -v ~/www:/usr/share/nginx/html nginx  


> no home - terminal 1
	$ CTRL a c

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

> opção 1 - sem interface gráfica  

	$ CTRL a c --- criar um novo shell no screen  
	$ lynx localhost:8080  

> opção 2 - com interface gráfica - no browser digite

	localhost:8080  







## Atividade 2 - criar uma imagem nginx


	$ nano Dockerfile4

>					FROM nginx 
>					RUN apt update && apt install -y nano  
>					COPY www/index.html /usr/share/nginx/html  


#### criar um container com a minha imagem 

	$ sudo docker pull nginx  

	$ sudo docker build -t nginxpadoin:latest -f Dockerfile4 .   

	$ sudo docker images

#### rodar o container

	$ sudo docker run --rm --name nginx -p 8080:80  nginxpadoin:latest  


### testar   

> opção 1 - sem interface gráfica  

	$ CTRL a c --- criar um novo shell no screen  
	$ lynx localhost:8080  

> opção 2 - com interface gráfica - no browser digite

	localhost:8080  