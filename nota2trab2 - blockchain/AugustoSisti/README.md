Aluno: Augusto Eduardo Sisti
# Instalação do Docker
```
    $ sudo apt install docker
    $ sudo apt install docker.io
```

# Block Chain

1. Criar uma pasta para dos dados
```
    $ mkdir ethereum
```

2. Criar um arquivo para o block chain
```
    $ nano ethereum/genesis.json
```

3. Colocar dentro do arquivo
```
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
    },
    "coinbase": "0x0000000000000000000000000000000000000000",
    "difficulty": "0x1000",
    "extraData": "",
    "gasLimit": "0x2fefd8",
    "nonce": "0x0000000000000111",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "timestamp": "0x00"
}
```

4. Baixar a imagem utilizada no docker ethereum/client-go:release-1.10
```
    $ sudo docker pull ethereum/client-go:release-1.10
```

5. Rodar o container em background
```
    $ sudo docker run -d --name ethereum-node -v $HOME/ethereum:/root -p 8545:8545 -p 8544:8544 -p 30301:30301 -p 30302:30302 -it --entrypoint=/bin/sh ethereum/client-go:release-1.10
```

6. Entrar no container
```
    $ sudo docker exec -it ethereum-node sh
```

7. Criar as contas (abrir novo terminal para cada uma)
```
    $ geth account new --datadir ~/guto1
    $ geth account new --datadir ~/guto2
    $ geth account new --datadir ~/guto3
```

8. Salvar as chaves públicas
```
    guto1: 0x46E3fb18e6cF2dbaD4806A729d60cB304059B366
    guto2: 0x1026884CB2030Af4042B02510b1D190eaE9f0d63
    guto3: 0x840c6a17aFfe6ea07b947b33548F4B7cAe481Fd6
```
![Alt text](<Criação da Conta 1-1.jpeg>)
![Alt text](<Criação da conta 2-1.jpeg>)
![Alt text](<Criação da conta 3-1.jpeg>)

9. Atualizar as chaves públicas dentro do arquivo genesis.json
```
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
   	   "0x46E3fb18e6cF2dbaD4806A729d60cB304059B366": {
   	 	"balance": "1000"
   	   },
   	   "0x1026884CB2030Af4042B02510b1D190eaE9f0d63": {
   	 	"balance": "2000"
   	   },
   	   "0x840c6a17aFfe6ea07b947b33548F4B7cAe481Fd6": {
   	 	"balance": "3000"
   	   }
    },
    "coinbase": "0x0000000000000000000000000000000000000000",
    "difficulty": "0x1000",
    "extraData": "",
    "gasLimit": "0x2fefd8",
    "nonce": "0x0000000000000111",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "timestamp": "0x00"
}
```

10. Iniciar os nós da rede (em cada terminal de acordo com a conta)
    Terminal guto1
    ```
    $ cd /root
    $ geth --datadir /root/guto1/ init genesis.json
    ```
    
    Terminal guto2
    ```
    $ cd /root
    $ geth --datadir /root/guto2/ init genesis.json
    ```

    Terminal guto3
    ```
    $ cd /root
    $ geth --datadir /root/guto3/ init genesis.json
    ```

11. Excutar o nó na rede em cada conta

    Terminal guto1
    ```
    $ geth --datadir ~/guto1 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8547 --allow-insecure-unlock console
    ```

    Terminal guto2
    ```
    $ geth --datadir ~/guto2 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8546 --port 30302 --http.port 8544 --allow-insecure-unlock console
    ```

    Terminal guto3
    ```
    $ geth --datadir ~/guto3 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8548 --port 30301 --http.port 8549 --allow-insecure-unlock console
    ```
    
12. Salvar os enodes
    ```
    guto1: enode://65b19345351ba7ff3042c76b57aaac60dd6ad0ed7aa6e387038b5d0d824d393fb9ff9071cc2a761dcf553cd3d92f824c3d6a9e5535e18af792c9fe822029eecc@127.0.0.1:30303

    guto2: enode://cf3188480b4647993767297a687b537f5fb6cbf67674c203773f50b01155a3ae9179cbf4f6a596be938ab7a488595d7cd825315db83a22692f7cef98212d3715@127.0.0.1:30301

    guto3: enode://4a92c8cf62650c571ed22013d82287c09c8d002c8d002ca6ec2ea82622cdcd00a24d105c1be40449495298f38fa7af60637c00259f285cd029c9d679e776a3d206456@127.0.0.1:30302 
    ```
13. Checar saldo inicial das contas
    ```
    guto1: $ eth.getBalance("0x46E3fb18e6cF2dbaD4806A729d60cB304059B366")
    ```
    ![Alt text](<Saldo Inicial Conta 1-1.jpeg>)
    ```
    guto2: $ eth.getBalance("0x1026884CB2030Af4042B02510b1D190eaE9f0d63")
    ```
    ![Alt text](<Saldo Inicial Conta 2-1.jpeg>)
    ```
    guto3: $ eth.getBalance("0x840c6a17aFfe6ea07b947b33548F4B7cAe481Fd6")
    ```
    ![Alt text](<Saldo Inicial Conta 3-1.jpeg>)
    
14. Conectar os Peers
    Terminal guto1
    ```
    $ admin.addPeer("enode://cf3188480b4647993767297a687b537f5fb6cbf67674c203773f50b01155a3ae9179cbf4f6a596be938ab7a488595d7cd825315db83a22692f7cef98212d3715@127.0.0.1:30301");
    $ admin.addPeer("enode://4a92c8cf62650c571ed22013d82287c09c8d002c8d002ca6ec2ea82622cdcd00a24d105c1be40449495298f38fa7af60637c00259f285cd029c9d679e776a3d206456@127.0.0.1:30302");
    ```
    Terminal guto2
    ```
    $ admin.addPeer("enode://65b19345351ba7ff3042c76b57aaac60dd6ad0ed7aa6e387038b5d0d824d393fb9ff9071cc2a761dcf553cd3d92f824c3d6a9e5535e18af792c9fe822029eecc@127.0.0.1:30303");
    $ admin.addPeer("enode://4a92c8cf62650c571ed22013d82287c09c8d002c8d002ca6ec2ea82622cdcd00a24d105c1be40449495298f38fa7af60637c00259f285cd029c9d679e776a3d206456@127.0.0.1:30302");
    ```
    Terminal guto3
    ```
    $ admin.addPeer("enode://65b19345351ba7ff3042c76b57aaac60dd6ad0ed7aa6e387038b5d0d824d393fb9ff9071cc2a761dcf553cd3d92f824c3d6a9e5535e18af792c9fe822029eecc@127.0.0.1:30303");
    $ admin.addPeer("enode://cf3188480b4647993767297a687b537f5fb6cbf67674c203773f50b01155a3ae9179cbf4f6a596be938ab7a488595d7cd825315db83a22692f7cef98212d3715@127.0.0.1:30301");
    ```

## Transações

### guto1 -> guto2 
15. Minerar para gerar gas
    Terminal guto1
    ```
    $ miner.start(2)
    $ miner.stop()
    ```
![Alt text](<Minerar Conta 1-1.jpeg>)

16. Checar Saldo 
    ```
    guto1: $ eth.getBalance("0x46E3fb18e6cF2dbaD4806A729d60cB304059B366")
    ```
![Alt text](<Saldo Após Minerar-1.jpeg>)

17. Desbloquear guto1
    ```
    $ personal.unlockAccount("0x46E3fb18e6cF2dbaD4806A729d60cB304059B366")
    ```

18. Transação guto1 -> guto2
    ```
    $ eth.sendTransaction({from:"0x46E3fb18e6cF2dbaD4806A729d60cB304059B366", to:"0x1026884CB2030Af4042B02510b1D190eaE9f0d63", value:111, gas: 21000})
    ```

19. Verificar se transação está na fila
    ```
    $ txpool.status
    ```
![Alt text](<Transação 1 pra 2-1.jpeg>)

20. Mineirar para liberar a transação
    ```
    $ miner.start(2)
    $ miner.stop()
    ```

22. Checar Saldo guto2
    ```
    guto2: $ eth.getBalance("0x1026884CB2030Af4042B02510b1D190eaE9f0d63")
    ```
![Alt text](<Saldo Conta 2 Após transação-1.jpeg>)

### guto2 -> guto3 
22. Minerar para gerar gas
    Terminal guto2
    ```
    $ miner.start(2)
    $ miner.stop()
    ```

23. Checar Saldo 
    ```
    guto2: $ eth.getBalance("0x1026884CB2030Af4042B02510b1D190eaE9f0d63")
    ```
![Alt text](<Saldo Conta 2 Após transação e minerar-2.jpeg>)

24. Desbloquear guto2
    ```
    $ personal.unlockAccount("0x1026884CB2030Af4042B02510b1D190eaE9f0d63")
    ```

25. Transação guto2 -> guto3
    ```
    $ eth.sendTransaction({from:"0x1026884CB2030Af4042B02510b1D190eaE9f0d63", to:"0x840c6a17aFfe6ea07b947b33548F4B7cAe481Fd6", value:222, gas: 21000})
    ```

26. Verificar se transação está na fila
    ```
    $ txpool.status
    ```
![Alt text](<Transação 2 pra 3-1.jpeg>)

27. Mineirar para liberar a transação
    ```
    $ miner.start(2)
    $ miner.stop()
    ```

28. Checar Saldo guto3
    ```
    guto2: $ eth.getBalance("0x840c6a17aFfe6ea07b947b33548F4B7cAe481Fd6")
    ```
![Alt text](<Saldo Conta 3 Após transação-1.jpeg>)

29. Parar o container
    ```
    $ sudo docker stop ethereum-node
    ```

# Novidade

1. Para ver a chave pública da conta que está em determinado terminal
    Em cada terminal
    ```
    $ personal.listAccounts
    ```
![Alt text](<Extra - Visualizar Conta 1-1.jpeg>)
![Alt text](<Extra - Visualizar Conta 2-1.jpeg>)
![Alt text](<Extra - Visualizar Conta 3-1.jpeg>)

2. Visualizar informações sobre Transações pendentes
    ```
    $ txpool.content
    ```
    
Fila Vazia
![Alt text](<Extra -Fila Transação Vazia-1.jpeg>)

Transações
![Alt text](<Extra -Transações-1.jpeg>)

Informações das Transações em Fila
![Alt text](<Extra - Informações Transações na Fila-1.jpeg>)
![Alt text](<Extra - Informações Transações na Fila 2-1.jpeg>)

Minerar para Efetuar as Transações e a Fila Vazia
![Alt text](<Extra - Minerar-1.jpeg>)

Fila vazia
![Alt text](<Extra - Fila Vazia-1.jpeg>)

Commit
