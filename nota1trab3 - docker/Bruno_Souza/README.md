## Nota1 Trab3 - Docker

## Autor
Bruno César Guisso de Souza

## Instalação em Host

```sudo apt-get install wordpress```

Isso instalará o WordPress no seu sistema Ubuntu. Em seguida, você precisará configurar o banco de dados MySQL para usar com o WordPress. Você pode fazer isso executando os seguintes comandos:
```sudo mysql -u root -p```
Em seguida, digite o comando:
```
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```
Substitua "your_password" pela senha desejada.
Agora é necessário editar o arquivo "/etc/wordpress/config-localhost.php" e adicionar o seguinte conteúdo:
```
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'your_password');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
```
Substitua "your_password" pela senha escolhida anteriormente.
Agora é possível acessar o WordPress no navegador digitando "http://localhost" ou usando o endereço local.

## Instalação com DockerFile

Instale o Docker e crie um arquivo chamado "Dockerfile" no diretório do projeto.

Abra o arquivo "Dockerfile" em um editor de texto e adicione o seguinte conteúdo:
```
# Use a official WordPress runtime as a parent image
FROM wordpress:php7.4-apache

# Install any needed packages specified in requirements.txt
COPY ./requirements.txt /usr/src/app/
RUN pip install --trusted-host pypi.python.org -r /usr/src/app/requirements.txt

# Install additional packages and setup WordPress
RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install the WordPress plugin from a URL
ENV WORDPRESS_PLUGIN_URL="https://downloads.wordpress.org/plugin/akismet.5.0.zip"
RUN wget -q "${WORDPRESS_PLUGIN_URL}" -O /tmp/akismet.zip \
    && unzip -q /tmp/akismet.zip -d /var/www/html/wp-content/plugins \
    && rm /tmp/akismet.zip

# Install the WordPress theme from a URL
ENV WORDPRESS_THEME_URL="https://downloads.wordpress.org/theme/twentynineteen.1.2.zip"
RUN wget -q "${WORDPRESS_THEME_URL}" -O /tmp/twentynineteen.zip \
    && unzip -q /tmp/twentynineteen.zip -d /var/www/html/wp-content/themes \
    && rm /tmp/twentynineteen.zip

# Copy custom files
COPY ./custom.wp-config.php /var/www/html/
COPY ./custom.htaccess /var/www/html/

# Expose ports for the Apache web server
EXPOSE 80
```

salve e feche o arquivo

No terminal, execute o comando para criar a imagem do Docker com o aplicativo WordPress:
```
docker run --name my-wordpress-site-container -d -p 8080:80 Dockerfile
```
Para Mudar o Nome:
```
docker build -t meu-site-wordpress .
```

Execute o comando para iniciar o container do aplicativo WordPress:
```
docker run --name my-wordpress-site-container -d -p 8080:80 meu-site-wordpress
```


Agora você pode acessar o WordPress no navegador digitando "http://localhost:8000".

## Instalação em Docker-Compose

crie um arquivo docker-compose.yml

```
version: '3'

services:
   db:
      image: mysql:5.7
      volumes:
         - db_data:/var/lib/mysql
      restart: always
      environment:
         MYSQL_ROOT_PASSWORD: somewordpress
         MYSQL_DATABASE: wordpress
         MYSQL_USER: wordpress
         MYSQL_PASSWORD: wordpress

   wordpress:
      depends_on:
         - db
      image: wordpress:latest
      ports:
         - "8000:80"
      restart: always
      environment:
         WORDPRESS_DB_HOST: db:3306
         WORDPRESS_DB_USER: wordpress
         WORDPRESS_DB_PASSWORD: wordpress
         WORDPRESS_DB_NAME: wordpress
volumes:
    db_data: {}
 ```

execute o comando para iniciar o container
```sudo docker-compose up -d```
Isso criará e iniciará dois containers, um para o banco de dados MySQL e outro para o WordPress. Você pode acessar o WordPress no navegador digitando "http://localhost:8000"