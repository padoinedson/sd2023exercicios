Sistemas Distribuídos
Nota 2 Trabalho 1
Aplicação de Blockchain em Aplicação Real

<p align="center">Explicação dos passos para instalação e realização das etapas para aplicar blockchain</p>

Lenya Ribeiro Ferreira


<h1 align="center"><<<<< a) CRIAÇÃO DE BLOCKCHAIN >>>>></h1>

Para criar uma blockchain, deve-se, inicialmente, configurar o container seguindo os seguintes passos:

1. Criar uma pasta que será compartilhada com o container e armazenará os dados do blockchain, com os comandos:

   a. cd ~

   b. mkdir ethereum

   c. nano genesis.json

      i. Colar as configurações disponibilizadas:

          {
              "config": {
                "chainId": 2023,
                "homesteadBlock": 0,
                "eip150Block": 0,
                "eip155Block": 0,
                "eip158Block": 0,
                "byzantiumBlock": 0,
                "constantinopleBlock": 0,
                "petersburgBlock": 0,
                "istanbulBlock": 0
              },
              "alloc": {
                          "0x90bA23C7A92C7d524E5B5cc9D6dA30D65Ba30944": {
                            "balance": "1000"
                          },
                          "0x90F8BE615B29B10B2E4B9BbF3ae17B970c86b955": {
                            "balance": "2000"
                          },
                          "0x90F8BE615B29B10B2Y57YU2F3ae17B970c86b955": {
                            "balance": "3000"
                          }
              },
              "coinbase": "0x0000000000000000000000000000000000000000",
              "difficulty": "0x20000",
              "extraData": "",
              "gasLimit": "0x2fefd8",
              "nonce": "0x0000000000000111",
              "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
              "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
              "timestamp": "0x00"
          }

   2. Baixar a imagem do Ethereum com o comando “sudo docker pull ethereum/client-go:release-1.10”

   3. Rodar o container com o comando “sudo docker run -d --name ethereum-node -v $HOME/ethereum:/root -p 8545:8545 -p 8544:8544 -p 30301:30301 -p 30302:30302 -it --entrypoint=/bin/sh ethereum/client-go:release-1.10”

   4. Abrir outras três guias no terminal, uma para cada uma das contas que serão utilizadas.

   5. De forma a executar o container e conferir se genesis.json está onde deveria, em cada uma dessas guias rodar os comandos:

      a. sudo docker exec -it ethereum-node sh

      b. cd /root

      c. ls

      d. cat genesis.json



<h1 align="center"><<<<< b) ADIÇÃO DAS CONTAS COM O SALDO >>>>></h1>

1. Antes de realizar transações entre as contas, é necessário criar as mesmas. Assim, deve-se rodar o comando “geth account new –datadir ~/nomedaconta”, substituindo “nomedaconta” pelos nomes das contas a serem criadas. Nos exemplos disponibilizados, as mesmas serão chamadas de “le1”, “le2” e “le3”. É importante rodar cada comando no terminal que foi definido para cada conta, facilitando a organização.

   a. Deve-se anotar os valores dos endereços das chaves e as senhas de cada uma dessas contas, senão não será possível realizar transações com elas.

      i. Endereço público de Le1:  0xAfd89dd896dc019A6Ed4225013502Dc11171c438

      ii. Endereço público de Le2: 0x4e08CA1d876909cC5292c2c6B693d7ac8192971e

      iii. Endereço público de Le3: 0xFEC74494F8e969da33a009308C2633E624C10788

   b. Substituir o valor das chaves no arquivo genesis.json para que estejam de acordo com as chaves geradas.

      i. cd ~

      ii. nano ethereum/genesis.json


<h1 align="center"><<<<< c) MINERAÇÃO PARA GERAR GAS >>>>></h1>

1. Deve-se inicializar os nós na rede antes de poder minerar para gerar gas.

   1. Em cada um dos terminais, executar os comandos:

      a. cd /root

      b. geth --datadir /root/nomedaconta/ init genesis.json

        i. Substituir “nomedaconta” pelo nome da conta.

2. Deve-se colocar os nós da rede para rodar.

   a. No terminal da primeira conta, executar o comando substituindo “nomedaconta” pelo nome da conta:

      i. geth --datadir ~/nomedaconta --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8547 --allow-insecure-unlock console

   b. Nos terminais da segunda e terceira conta, executar o comando:

      i. geth --datadir ~/nomedaconta --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8546 --port 30302 --http.port 8544 --allow-insecure-unlock console
        
         Importante: Deve-se substituir a porta por uma adequada, tente até conseguir obter uma que esteja livre.
   
    c. Não pode-se esquecer de anotar o enode de cada uma das contas.

        i. Enode de Le1: self=enode://9bdc82c396e402d233178e90f01837c158c472ca88604b1d3e6f0f3188a445221925a96cc5703d27104d847028d963e1137cb481fd425db7df26e952b310cefb@127.0.0.1:30303

        ii. Enode de Le2: self=enode://66d5b13ed669324528434d7effeceb85ec58afabba3e966da70aa4702e31d0675fb6e5e0cd58567bba7be96d7cfe0ce2eca948f964ea4f44386a813576c35605@127.0.0.1:30302
        
        iii. Enode de Le3: self=enode://8e2895778341501547dca232c62a8fd014929d9c6352af654416644f81113e4c57e87ef61bf9902b9ec60d350ffb6d896f475f87508f7dc8a3b037c7f4d29f89@127.0.0.1:30902

3. Por fim, pode-se executar a mineração com o comando “miner.start(10)”, sendo que o número é indicativo da quantidade de threads.

4. Para parar a mineração, usa-se “miner.stop()”.


<h1 align="center"><<<<< d) REALIZAÇÃO DAS TRANSFERÊNCIAS >>>>></h1>

1. Antes de conseguir trocar saldo entre as contas, deve-se adicionar uma à outra.

    a. admin.addPeer("enodedooutrono")

        i. Substituir "enodedooutrono" pelo enode dos outros nós.
       
        ii. No caso da primeira conta, ficará assim: admin.addPeer("enode://8e2895778341501547dca232c62a8fd014929d9c6352af654416644f81113e4c57e87ef61bf9902b9ec60d350ffb6d896f475f87508f7dc8a3b037c7f4d29f89@127.0.0.1:30902")

        admin.addPeer("enode://66d5b13ed669324528434d7effeceb85ec58afabba3e966da70aa4702e31d0675fb6e5e0cd58567bba7be96d7cfe0ce2eca948f964ea4f44386a813576c35605@127.0.0.1:30302")

        iii. Segunda conta: admin.addPeer("enode://8e2895778341501547dca232c62a8fd014929d9c6352af654416644f81113e4c57e87ef61bf9902b9ec60d350ffb6d896f475f87508f7dc8a3b037c7f4d29f89@127.0.0.1:30902")

        admin.addPeer("enode://9bdc82c396e402d233178e90f01837c158c472ca88604b1d3e6f0f3188a445221925a96cc5703d27104d847028d963e1137cb481fd425db7df26e952b310cefb@127.0.0.1:30303")

        iv. Terceira conta: 
        admin.addPeer("enode://9bdc82c396e402d233178e90f01837c158c472ca88604b1d3e6f0f3188a445221925a96cc5703d27104d847028d963e1137cb481fd425db7df26e952b310cefb@127.0.0.1:30303")

        admin.addPeer("enode://66d5b13ed669324528434d7effeceb85ec58afabba3e966da70aa4702e31d0675fb6e5e0cd58567bba7be96d7cfe0ce2eca948f964ea4f44386a813576c35605@127.0.0.1:30302")

2. Deve-se liberar a conta antes de usar ela, substituindo “chave” pela chave de cada uma das contas. Repetir o comando nos terminais de cada uma das contas:

   a. personal.unlockAccount("chave")

3. Executar o comando no terminal da conta que enviará o dinheiro, substituindo “chavedaconta1” pela chave da primeira conta e “chavedaconta2” pela chave da segunda conta.

   a. eth.sendTransaction({from:"chavedaconta1", to:"chavedaconta2", value:111, gas:21000})

4. Verificar o status da transação com “txpool.status”.


<h1 align="center"><<<<< e) MINERAÇÃO PARA EFETIVAÇÃO DAS TRANSFERÊNCIAS >>>>></h1>

1. Visto que é necessário minerar para efetivar a transação, executar o comando “miner.start(10)” para iniciar e “miner.stop()” para parar.

2. Verificar o status da transação com “txpool.status”.

3. Repetir o processo com o valor sendo transferido de 222, da segunda conta para a terceira.


<h1 align="center"><<<<< f) NOVIDADES EM RELAÇÃO AO EXEMPLO DE AULA >>>>></h1>


1.  É necessário pagar uma taxa de gas para efetuar cada transação. Assim, também é possível alterar o valor do preço mínimo de gas que será aceito nas transações de mineração. A novidade que foi trazida em relação à aula foi um estudo das possibilidades do uso do GETH, que possui um comando que permite a alteração da quantidade de gas necessário quando se procura enviar créditos de uma conta para outra.

2. Para isso, usa-se "geth --help" para observar a lista de comandos. Encontrando o que se deseja, pode-se observar a estrutura que deve ser utilizada.

3. Eecutar o comando "miner.setGasPrice(valor)", substituindo “valor” pelo valor mínimo de gas que se deseja configurar para as transações. No exemplo foi utilizado o valor 10.

4. A mensagem de sucesso deve aparecer na tela.

   a. https://imgur.com/NqKJtYI

<h1 align="center"><<<<< Extra) PRINTS >>>>></h1>

Os prints foram postados juntos da atividade, entretanto, também será disponibilizado o link com todos os prints reunidos:

b) 5 prints de tela com: (10 pontos)

https://docs.google.com/document/d/1MUtElfALJnfeK5h9An09G6xr2nuh1pVDBs2qhpLUVlI/edit?usp=sharing

c) 3 prints de tela com: (10 pontos)

https://docs.google.com/document/d/1nScSLa1uxy_OIRgynysceS9sW2cTQugjF6eCy61JB4I/edit?usp=sharing