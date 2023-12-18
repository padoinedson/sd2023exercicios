Readme com as instruções necessárias para realizar a mineração e transação com blockchain.


Primeiramente, para realizar a criação da blockchain, é criado um diretório chamado ethereum


$ mkdir ethereum


Então é criado um arquivo genesis.json
que irá conter as configurações da blockchain e de três contas que vão receber um saldo inicial e quando criadas uma chave pública que será anexada neste arquivo.


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
                          "0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6": {
                            "balance": "1000"
                          },
                          "0x612eb303D4bAfbE04dC23B18d6a821e183C94424": {
                            "balance": "2000"
                          },
                          "0x25BAC677518Bb8699b8CCfA48ce759eBa7f62c83": {
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


Depois é baixada a imagem do docker do ethereum que será rodada


$ sudo docker pull ethereum/client-go:release-1.10


Logo após em outros três terminais  o container é rodado um comando para rodar o container do docker 


Primeiro terminal


$ sudo docker run -d --name ethereum-node -v $HOME/ethereum:/root -p 8545:8545 -p 8544:8544 -p 30301:30301 -p 30302:30302 -it --entrypoint=/bin/sh ethereum/client-go:release-1.10


Segundo e terceiro terminal 


$ sudo docker exec -it ethereum-node sh


Agora será criada as contas, dentro do containers de cada terminal onde as contas serão criadas, deve ir para o diretório root para poder realizar as demais etapas 


$cd /root


<<CRIANDO CONTA>>


Assim rodar o seguinte comando onde teste1 será o nome da conta criada, sendo substituído no terminal dois por teste 2 e no 3 para teste3


$ geth account new --datadir ~/teste1
$ geth account new --datadir ~/teste1
$ geth account new --datadir ~/teste1


Então uma chave pública é criada para cada uma das 3 contas, as mesmas são colocadas no arquivo genesis, podem ser modificadas atráves do comando nano genesis.json ou manualmente.


chave pública teste1  0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6
chave pública teste2  0x612eb303D4bAfbE04dC23B18d6a821e183C94424
chave pública teste3  0x25BAC677518Bb8699b8CCfA48ce759eBa7f62c83


Agora que o arquivo genesis foi modificado para receber a chave das 3 contas, é inicializado os nós na rede.

$ geth --datadir /root/teste1/ init genesis.json
$ geth --datadir /root/teste2/ init genesis.json
$ geth --datadir /root/teste3/ init genesis.json


Com o gênesis iniciado, os nós vão ser rodados com os comando a baixo, a porta deve mudar para as demais contas. 


$ geth --datadir ~/teste1 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8547 --allow-insecure-unlock console


$ geth --datadir ~/teste2 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8546 --port 30302 --http.port 8544 --allow-insecure-unlock console


$ geth --datadir ~/teste3 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8544 --port 30303 --http.port 8546 --allow-insecure-unlock console


<<ADICIONANDO PEER>>


Com as contas criadas é adicionado um peer para cada uma delas, a teste1 irá receber a o enode da teste2 e teste3, a teste2 recebe da teste1 e teste3 e a teste3 recebe da teste1 e teste2.


> Para a teste1


teste2
admin.addPeer("enode://723f76f46edfdc761ea01871aa02a14148e08dbb811777616c085bedbef22d2ec3a1746e4b294fc5a7dc35ca8ee4a825939e998635db650556b53bafd0fda586@127.0.0.1:30302");


teste3


admin.addPeer("enode://302e9cf29d6c1f49a8c6a6f258e8d7840040e34f0bdb971b5f2108c64bae3b1bb78e2ed5869a36a92e4c471bb3e49d7b56b5ec6994cca1e81d68a0195f7e702b@127.0.0.1:5");


> Para a teste2


teste1 


admin.addPeer("enode://4df0183756b0eb70722539dbff62fb42d8aadadcecc69ad8b11d7a2b412c812bf32706df4bc533d27eb39748b98a4408cd4c62f5e4287ffb21e40edf6e937309@127.0.0.1:30303");


teste3


admin.addPeer("enode://302e9cf29d6c1f49a8c6a6f258e8d7840040e34f0bdb971b5f2108c64bae3b1bb78e2ed5869a36a92e4c471bb3e49d7b56b5ec6994cca1e81d68a0195f7e702b@127.0.0.1:5");




> Para a teste3


teste1


admin.addPeer("enode://4df0183756b0eb70722539dbff62fb42d8aadadcecc69ad8b11d7a2b412c812bf32706df4bc533d27eb39748b98a4408cd4c62f5e4287ffb21e40edf6e937309@127.0.0.1:30303");


teste2


admin.addPeer("enode://723f76f46edfdc761ea01871aa02a14148e08dbb811777616c085bedbef22d2ec3a1746e4b294fc5a7dc35ca8ee4a825939e998635db650556b53bafd0fda586@127.0.0.1:30302");


<<MINERAÇÃO>>


Agora que todas as contas receberam os peers das outras, será inicializada a miração com 10 threads


$ miner.start(10)


E para parar a mineração será rodado


$ miner.stop()


<<CONFERINDO SALDO>>


Então após a realização da mineração confere-se o saldo das contas com o seguinte comando.


> teste1
eth.getBalance("0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6")


> teste2
eth.getBalance("0x612eb303D4bAfbE04dC23B18d6a821e183C94424")


> teste3
eth.getBalance("0x25BAC677518Bb8699b8CCfA48ce759eBa7f62c83")


<<DESBLOQUEANDO CONTA>>


Quando as duas contas que forem realizar a transferência estiverem desbloqueadas, então pode ser realizada a transação.


Para desbloquear as contas deve ser executado o seguinte comando


> teste1
personal.unlockAccount("0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6")


> teste2
personal.unlockAccount("0x612eb303D4bAfbE04dC23B18d6a821e183C94424")


> teste3
personal.unlockAccount("0x25BAC677518Bb8699b8CCfA48ce759eBa7f62c83")


<<TRANSFERINDO SALDO>>


Para realizar a transferência de saldo é rodado o seguinte comando. Deve ser informado de qual a conta será retirado o valor e depois para qual conta será depositado, para isso é informada a chave pública da conta, e, logo após, o valor que será transferido.


> Transferindo saldo da teste1 para a teste2
eth.sendTransaction({from:"0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6", to:"0x612eb303D4bAfbE04dC23B18d6a821e183C94424", value:111, gas:21000})


> Transferindo saldo da teste2 para a teste3
eth.sendTransaction({from:"0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6", to:"0x25BAC677518Bb8699b8CCfA48ce759eBa7f62c83", value:222, gas:21000})


Depois de transferido é verificado o status da transação para checar se a requisiçãoi ainda está pendente, ou se já foi realizada.


$ txpool.status


{
pending: 1,
queued: 0
}


Quando não estiver mais pendente, pode ser conferido o saldo das contas novamente para verificar se o saldo foi alterado.


> teste1
eth.getBalance("0xaa1272E48f76Dc3A2e05E6f221a1304A09b839B6")


> teste2
eth.getBalance("0x612eb303D4bAfbE04dC23B18d6a821e183C94424")


> teste3
eth.getBalance("0x25BAC677518Bb8699b8CCfA48ce759eBa7f62c83")


<<NOVIDADE PARA BLOCKCHAIN>>


Agora com as transações feitas entre as contas, usando o geth é possível exportar as contas para um arquivo binário.


Exportando blockchains para arquivo binário, assim é possível posteriormente realizar a importação, esse método serve como uma forma de backup das contas, basta ter o arquivo da conta no formato rlp e fazer o import da mesma. 


Comando realizado foi o de export da conta


$ sudo geth export teste1.rlp


$ sudo geth export teste2.rlp


$ sudo geth export teste3.rlp


Os arquivos vão aparecer na pasta junto às contas e ao arquivo genesis.


Prints do processo estão dentro da pasta Prints. 
Os prints da melhoria estão na pasta Print-novidade