Serviço escolhido: ruby

<<<<< INSTALAÇÃO NO HOST >>>>>

$ Para começar usei o comando sudo apt update para atualizar minhas listas. 

$ Usei o comando sudo apt install ruby-full para baixar o ruby na minha maquina.

$ Após isso, usei o comando ruby --version para ver se baixou sem erro.

$ Criei um arquivo chamado test.ruby pra ver se a execução esta funcionando, nesse arquivo contem o que desejo printar na tela.

$ usei o comando ruby test.rb para mostrar o funcionamento do codigo.

<<<<< INSTALAÇÃO EM DOCKER-RUN >>>>>

$ Primeiro usei o comando: sudo docker pull ruby, para baixar a imagem, mas pode subistituir o ruby por qual imagem deseja.

$ Usei o comando: sudo docker ps para ver se a imagem foi criada.

$ Após ter certeza que a imagem foi criada, usei o comando: sudo docker run -it ruby /bin/bash  para executar ela.

$ Para a parte de teste, usei o comandos que estao no print com o nome: DOCKER-RUN.png

<<<<< INSTALAÇÃO EM CONTAINER >>>>>

$ Para começar, criar um arquivo chamaddo Dockerfile no qual ele vai ter as suas informações para criar sua imagen.

$ Após isso executa o comando: sudo docker build -t imgruby:1.0.0 -f Dockerfile.

$ Assim que executar o comando acima, usa o comando: suco docker images, para ver suas imagens criadas e ver se ela foi criado com êxito.

$ Indo para parte de conectar com o container, usa o comando: sudo docker run -it imgruby:1.0.0 /bin/bash para entrar nesse conteiner.

$ Entrando no container, vamos usar alguns comando para ver o seu funcionamento, usando o irb e depois usamos puts "olá, Ruby #{RUBY_VERSION}!" no qual vai mostrar a mensagem e a sua versão.

<<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>

$ Instalar o docker-compose, com o comando: sudo apt install docker-compose.

$ Primeiro, devemos riar um arquivo com o nome: docker-compose.yml, no qual vai ter as configuração que deseja instalar.

$ após isso, usa o comando: sudo docker-compose up -d, esse comando serve para rodar o arquivo criado anteriormente, e o "-d" vai fazer rodar em background.

$ após isso usa o comando sudo docker ps para ver as imagem criado, e se foi criado com sucesso.

$ Para executar o conteiner, usa o comando: sudo docker exec -it rubycomp bash, lembrando de subistituir a parte do rubycomp para o nome do conteiner que você colocou no arquivo docker-compose.yml.
