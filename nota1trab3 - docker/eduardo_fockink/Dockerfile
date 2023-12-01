# Use a imagem oficial do Ubuntu como base
FROM ubuntu:23.04

# Define metadados usando rótulos'
LABEL maintainer="Eduardo Fockink Silva"
LABEL description="Configuração do Nginx para TRABALHO 3 NOTA 1"

# Instala as dependências necessárias
RUN apt update && apt install -y \
    curl \
    gnupg2 \
    ca-certificates \
    lsb-release \
    ubuntu-keyring \
 && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
 && echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list \
 && echo "Package: *" > /etc/apt/preferences.d/99nginx \
 && echo "Pin: origin nginx.org" >> /etc/apt/preferences.d/99nginx \
 && echo "Pin: release o=nginx" >> /etc/apt/preferences.d/99nginx \
 && echo "Pin-Priority: 900\n" >> /etc/apt/preferences.d/99nginx \
 && apt-get update \
 && apt-get install -y nginx \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
# Copia os arquivos de configuração 
COPY files/nginx/ /usr/share/nginx/
COPY files/conf.d/ /etc/nginx/conf.d/

# Expoem a porta padrão do Nginx
EXPOSE 8080
EXPOSE 9090   

# Comando para iniciar o Nginx em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
