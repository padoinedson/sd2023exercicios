


####	Test - mosquitto com docker




> criar uma pasta   

$ mkdir docker-mqtt  


> entrar na pasta  

$ cd docker-mqtt  


> criar um arquivo Dockerfile  

$ nano Dockerfile 


		# Dockerfile for mosquitto  
 


		FROM ubuntu  

		RUN apt-get update -y  

		RUN apt-get -y install net-tools  

		RUN apt-get -y install iputils-ping  

		RUN groupadd -g 1883 mosquitto && \  
		    useradd -r -u 1883 -g mosquitto mosquitto  

		RUN apt install mosquitto -y  

		RUN apt install mosquitto-clients -y  

		EXPOSE 1883  

		CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf]  



> criar uma imagem  

$ docker build -t mosquitto -f Dockerfile .   


> desistalar o docker do host   

$ sudo apt remove mosquitto  


> criar um container  

$ docker run -it -p 1883:1883 -p 9001:9001 mosquitto /bin/bash  


> levantar mosquitto  

$ mosquitto &  

 


> subscribe no terminal 1

$ mosquitto_sub -h localhost -v -t '#'  


> publish no terminal 2  

$ mosquitto_pub -h 172.17.0.2 -m "nome" -t teste  



