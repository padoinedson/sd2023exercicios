    <<<<< INSTALAÇÃO NO HOST >>>>>
Para a instalação no host, é necessário fazer o uso do terminal e rodar os seguintes comandos:
1.sudo apt install mysql-server
	Aqui, será instalado o servidor mysql na máquina.

2. mysql --version
	Aqui, será indicado qual a versão do seu mysql server.

3. sudo systemctl status mysql
	Por fim, usa-se esse comando para verificar se o servidor está ativo.



      arquivo instalacao.md  

       <<<<< INSTALAÇÃO EM CONTAINER >>>
Para instalação em container, é necessário seguir os seguintes passos:
1. Criar a imagem.
Criar um arquivo Dockerfile com a estrutura: 
  FROM mysql  
  MAINTAINER nome
Executar o comando  “sudo docker build -t mysql2023 .” no diretório do arquivo Dockerfile.
Pode-se exibir e inspecionar a imagem com os comandos “sudo docker images” e “sudo docker image inspect mysql2023” respectivamente.
2. Criar um container.
Rodar os comandos “screen” e “sudo docker run --name mysqltrabalho -e MYSQL_ROOT_PASSWORD=123 mysql2023 -d”.
O “-d” serve para o container seja posto em execução no background. Útil para quando se está usando um servidor sem interface gráfica, pois a linha de comando ainda pode ser usada.
Pode-se checar o container sendo executado com os comandos “sudo docker top mysql2023d” e “sudo docker logs mysql2023”.
Acessa-se o container com “sudo docker exec -it mysql2023docker bash”.
3. Para acessar o MySQL e realizar operações em cima das tabelas, usa-se “mysql -u root -p”.
Usa-se “exit” para encerrar as operações e, novamente, para sair do container/
4. Parar o container com “sudo docker stop mysql2023”.


       <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>
1. Instala-se o docker-compose com “sudo apt install docker-compose”.
2. Cria-se o arquivo docker-compose.yml com a estrutura
	version: '3'
	services:
	  db:
	    image: mysql:5.7
	    container_name: mysqltrabalho
	#    ports:
	#      - 13306:3306
	#    volumes: 
	#      - ./init.sql:/data/application/init.sql
	    environment: 
	      MYSQL_ROOT_PASSWORD: 123
3. Executa-se os containers com o comando “screen”, tal qual no modo anterior. Depois, usa-se o comando “sudo docker-compose up -d” para rodar em background.
4. O acesso ao container é com “sudo docker exec -it mysqltrabalho bash”.
5. Acessa-se o MySQL da mesma forma que o modo anterior, com “mysql -u root -p”.
6. Pode-se executar as operações no MYSQL. No print disponibilizado, foram executados os comandos "CREATE DATABSE SD2023;" (para criar uma database) e "SHOW DATABASE;" (para mostrar as databases criadas". Usa-se "exit" para sair.
7. Para encerrar as atividades do container, usa-se “sudo docker-compose down”.
