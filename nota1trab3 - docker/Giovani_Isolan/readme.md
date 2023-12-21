
Instalar Alpine no Docker

Primeiramente: 

Instalar o Docker no Linux

apt-get install docker.io

Inice um servico docker com:

service docker start

Caso queira ver a versao do docker:
 
docker version

Ver as imagens disponiveis: docker images

<img src="imagens/7e4fc71f-af4f-46a7-a71b-b8115dbd5944.jpg"></img>
Baixar a imagem do alpine: docker pull alpine 
<img src="imagens/d2535b72-8be3-4744-9c37-946fd10e9c2b.jpg
"><img>

Inicie o docker alpine: docker run -t alpine

<img src="imagens/ee9b7884-002e-4b66-9c27-84ef0ce2f14b.jpg"></img>
use o comando "exit" para sair
 
Proximo passo:

Para criar um contêiner Docker Alpine usando o Docker Compose, você precisará criar um arquivo docker-compose.yml e definir as configurações necessárias.

Crie um arquivo docker-compose.yml
e escreva isso dentro dele:
<img src="imagens/54fc9f2c-09ba-4015-958f-84ad62eb4108.jpg"><img>

Certifique-se de que o Docker e o Docker Compose estejam instalados em seu sistema.

Navegue até o diretório que contém o arquivo docker-compose.yml.

Execute o seguinte comando para criar e iniciar o contêiner:

docker-compose up -d

O uso do -d faz com que o Docker Compose execute em segundo plano.

<img src="imagens/dd2f28b6-4f94-4137-8937-46251364aaff.jpg"></img>
Você pode verificar se o contêiner Alpine está em execução em segundo plano usando o seguinte comando:

docker ps
<img src="imagens/4ef150ff-904c-4e70-aacb-72802fc3a6de.jpg"></img>

Criar um dockerfile:

Crie um diretório para o seu projeto

mkdir nome-do-seu-projeto
cd nome-do-seu-projeto

com o nano coloque essa informacao dentro do seu dockerfile:

<img src="imagens/d23801a1-c6f4-416f-8780-9025232e5d59.jpg"><img>

salve o arquivo

Agora, você pode criar uma imagem Docker com base nesse Dockerfile. Certifique-se de estar no diretório onde o Dockerfile está localizado e execute o seguinte comando:

docker build -t meu-contenedor-alpine .
<img src="imagens/975b6bb0-5d21-488a-b60f-fd8855d18ede.jpg">

para verficar se a imagem foi criada use o comando

docker images

<img src="imagens/921d1a38-bfa3-44a8-8c2a-d73dce694384.jpg">