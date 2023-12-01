# instalacao.md - Instalação do Nginx e Docker em Ubuntu

## Eduardo Fockink Silva - Trabalho 3 Nota 1 - Dezembro / 23

Este documento descreve o passo a passo para instalar e configurar o Nginx e Docker em um sistema Ubuntu, focando em configurações para servir dois sites diferentes nas portas 8080 e 9090.

**Sumário:**

1. Preparação Inicial
2. Instalação do Nginx
3. Pós-instalação do Nginx
4. Instalação do Docker e Docker Compose
5. Pós-instalação do Docker

## 1. Preparação Inicial

### Verificações e Configurações Iniciais

1. Verifique se as portas 8080 e 9090 não estão em uso:

    ```bash
    sudo lsof -i -P -n | grep -E "8080|9090"
    ```

2. Prepare o diretório de trabalho:

    ```bash
    mv eduardo_fockink/ ~/
    cd ~/eduardo_fockink/
    ```

## 2. Instalação do Nginx

[Documentação oficial para instalar o Nginx](https://nginx.org/en/linux_packages.html#Ubuntu).

### Preparação do Ambiente

1. **Instale as dependências necessárias:**
    ```bash
    sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring
    ```

2. **Adicione a chave GPG oficial do Nginx:** 
    ```bash
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
    ```

    - Verifique a chave:

        ```bash
        gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
        ```

        O resultado deve mostrar a chave com a impressão digital correta (573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62).

3. **Configure o repositório do Nginx:**

    ```bash
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
    ```

4. **Priorize os pacotes do Nginx:**

    ```bash
    echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | sudo tee /etc/apt/preferences.d/99nginx
    ```

### Instalação do Nginx

1. **Instale o Nginx:**

    ```bash
    sudo apt update
    sudo apt install -y nginx
    ```

## 3. Pós-instalação do Nginx


1. **Inicie o serviço Nginx:**

    ```bash
    sudo systemctl start nginx
    ```

    - Verifique se o Nginx esta servindo o site na porta 80.

        [Link Site Padrão do Nginx](http://localhost:80/)


2. **Configure os hosts virtuais e páginas:**

    ```bash
    sudo cp -r ~/eduardo_fockink/files/nginx/ /usr/share/
    sudo cp -r ~/eduardo_fockink/files/conf.d /etc/nginx/
    sudo systemctl restart nginx
    ```

    - Verifique se os sites estão online:

        [Link Site 1](http://localhost:8080/)

        [Link Site 2](http://localhost:9090/)

## 4. Instalação do Docker e Docker-Compose

Documentação oficial para instalar o [Docker](https://docs.docker.com/engine/install/ubuntu/) e o [Dcoker-compose](https://docs.docker.com/compose/install/)

### Preparação do Ambiente

1. **Remova instalações anteriores:**

    ```bash
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
    sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin docker-ce-rootless-extras
    sudo rm -rf /var/lib/docker /var/lib/containerd
    ```

2. **Instale dependências necessárias:**

    ```bash
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg
    ```

3. **Adicione a chave GPG oficial do Docker:**

    ```bash
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    ```

4. **Configure o repositório do Docker:**

    ```bash
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

### Instalação do Docker e Docker Compose

1. **Instale o Docker e o Docker Compose:**

    ```bash
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin
    ```

## 5. Pós-instalação do Docker

1. **Verifique o estado do serviço Docker:**

    ```bash
    sudo systemctl status docker
    ```

   - Inicie o Dcoker, se necessário:

        ```bash
        sudo systemctl start docker
        ```

2. **Teste o Docker:**

    ```bash
    sudo docker run hello-world
    ```

    A mensagem "Hello from Docker!" confirá que a instalação foi bem-sucedida.

3. **Limpeza e Manutenção:**

    ```bash
    sudo docker rm $(sudo docker ps -a -q -f "ancestor=hello-world")
    sudo docker rmi hello-world
    ```

4. **Configure privilégios de usuário:**

    ```bash
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    ```

    - Verifiquei se o priviléfio foi configurado corretamente usando o comando Docker sem sudo:

        ```bash
        docker ps -a
        ```


