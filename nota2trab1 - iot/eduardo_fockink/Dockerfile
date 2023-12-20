FROM nginx:latest

LABEL maintainer="Eduardo Fockink Silva"
LABEL description="Configuração do Nginx para TRABALHO 1 NOTA 2"

COPY files/nginx/ /usr/share/nginx/
COPY files/conf.d/ /etc/nginx/conf.d/

EXPOSE 8080
EXPOSE 9090   

CMD ["nginx", "-g", "daemon off;"]