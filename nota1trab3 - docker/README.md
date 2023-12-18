<<<<< INSTALAÇÃO NO HOST >>>>>
    
    Agora que a instalação do docker foi concluída; procuramos, baixamos e executamos a imagem que escolhemos:
    
    Procurar a imagem: sudo docker search hello-world.
    Baixar: sudo docker pull hello-world.
    Criar e executar o container: sudo docker run -it hello-world
    ![Alt text](I.png)

<<<<< INSTALAÇÃO EM CONTAINER >>>>>
       
    Criar um arquivo com o nome de Dockerfile.
    Dentro do arquivo, colocar as instruções:
    ![Alt text](<II 1.png>)
    No diretório onde está localizado o arquivo Dockerfile, executar: sudo docker build -t hello-world-a:1.0.0 -f Dockerfile .
    ![Alt text](<II 2.png>)

<<<<< INSTALAÇÃO EM CONTAINER VIA COMPOSE >>>>>

    Criar um arquivo chamado docker-compose.yaml
    Dentro do arquivo docker-compose.yaml, colocar as instruções:
    ![Alt text](<III 1.png>)
    Executar no diretório onde está o arquivo docker-compose.yaml: sudo docker-compose up -d.
    ![Alt text](<III 2.png>)
    Executar um comando diretamente no container, sem acessá-lo: sudo docker exec -it optimistic_hugle bash -c "apt-get update".
    ![Alt text](IV.png)



