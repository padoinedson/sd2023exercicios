      <<<<< INSTALAÇÃO NO HOST >>>>>

Primeiramente é realizada a instalação do docker através do comando 
sudo apt install docker e sudo apt install docker.io
Agora com o docker instalado é feita a inicialização do mesmo através de sudo
systemctl start docker
Depois deve ser baixada a imagem do serviço utilizando, para este trabalho foi escolhido      o Ubuntu, então para baixar a imagem utilizando o comando 
docker pull ubuntu
Agora com a imagem instalada é executado o comando para rodar  o container do ubuntu no docker:
docker run ubuntu
Que fará com que o contêiner seja executado. 
Através do comando 
sudo docker ps 
É possível visualizar os container criados. Para ativar o container é executado o seguinte comando 
sudo docker start ubuntu 


       <<<<< INSTALAÇÃO EM CONTAINER >>>>>
       arquivo Dockerfile

Primeiro para fazer a instalação é necessário criar a imagem, e para isso é criado um arquivo chamado Dockerfile
Em seguida deve entrar no diretório onde foi salvo o Dockerfile e executado o comando 
docker build -t ubuntu:jammy -f Dockerfile2 .
para construir a imagem
Executando um contêiner a partir da imagem:
Agora que a imagem foi criada, pode-se criar e executar um contêiner a partir dela:
docker run -it ubuntu:jammy


       <<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>
       arquivo docker-compose.yml
Para fazer a instalação via docker compose deve se instalar o docker compose
sudo apt install docker-compose
E depois de instalado rodar o seguinte comando para fazer o build do docker-compose
docker-compose  –version
Em seguida é criada uma pasta onde será armazenado o container
mkdir ~/compose-demo
Agora é criado um arquivo chamado docker-compose.yml
onde terá os comando yml que vão fazer o docker rodar
E por fim, para subir o container é executado o comando 
docker-compose up -d
Para visualizar a imagem criada 
docker-compose ps

