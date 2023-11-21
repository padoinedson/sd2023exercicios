1-- Deve ser instalado o Docker caso não esteja instalado pelos comandos: `sudo apt install docker`, `sudo apt install`, `sudo apt install docker-compose`.

2-- Agora após instalado devemos escolher uma imagem a ser utilizada, você pode encontrar imagens a serem utilizadas no site: https://hub.docker.com/.
A imagem que iremos utilizar na realização deste trabalho é do serviço Rabbitmq, você pode obter as informações dela atraves do link: https://hub.docker.com/_/rabbitmq.
O comando para utilizar a imagem é `sudo docker pull rabbitmq`.

3--Após a criação da imagem você irá rodar o comando `sudo docker run "o nome da sua imagem"`, no meu caso o comando a ser utilizado é `sudo docker run rabbitmq`.  
Pronto agora temos o primeiro docker feito

4-- Agora vamos criar o arguivo Dockerfile, você ira digitar `nano Dockerfile` e ira incluir as seguintes informações:
  		FROM    # deve ser a primeira instrução - de qual imagem base vou criar a minha
  		RUN  		# comando que vai ser rodado na instalação
  		ENV     #
  		CMD     # deve ser a última instrução - qual comando vai ser executado qdo o container for levantado

Essas informações no site do docker irá te informar maioria das vezes, o conteudo da meu arquivo Dockerfile será: 
#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM rabbitmq:3.13-rc

RUN set eux; \
	rabbitmq-plugins enable --offline rabbitmq_management; \
# make sure the metrics collector is re-enabled (disabled in the base image for Prometheus-style metrics by default)
	rm -f /etc/rabbitmq/conf.d/20-management_agent.disable_metrics_collector.conf; \
# grab "rabbitmqadmin" from inside the "rabbitmq_management-X.Y.Z" plugin folder
# see https://github.com/docker-library/rabbitmq/issues/207
	cp /plugins/rabbitmq_management-*/priv/www/cli/rabbitmqadmin /usr/local/bin/rabbitmqadmin; \
	[ -s /usr/local/bin/rabbitmqadmin ]; \
	chmod +x /usr/local/bin/rabbitmqadmin; \
	apt-get update; \
	apt-get install -y --no-install-recommends python3; \
	rm -rf /var/lib/apt/lists/*; \
	rabbitmqadmin --version

EXPOSE 15671 15672


Após ter salvado o arquivo Dockerfile você irá digitar o comando `sudo docker build -t rabbitmq:3.13 - f Dockerfile .`
Com esse comando você irá criar uma imagem com o conteudo do Dockerfile, para executar este container execute o comando `sudo docker run -it rabbitmq3.13 /bin/bash` e para sair do container apenas de o comando exit

5-- O docker-compose você cria um arquivo nomeado docker-compose.yaml e definir as configurações que deseja para a imagem existente.
O conteudo que eu utilizei foi:

version: '3'
services:
  rabbitmq:
    image: rabbitmq:3.13
    container_name: docker_rabbitmq
    stdin_open: true
    tty: true

Para rodar foi utilizado o comando `sudo docker-compose up -d` após isto para realizar o teste do serviço foi usado o comando `sudo docker run -d --hostname my-rabbit --name some-rabbit rabbitmq:3 ` e após ter funcionado utilizei o comando `sudo docker logs some-rabbit` para ver se deu certo o serviço do rabbitmq.
