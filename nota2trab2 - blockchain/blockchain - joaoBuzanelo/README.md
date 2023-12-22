
## Blockchain
criar doretorio ethereum
`mkdir ethereum`

criar um arquivo com o nome de `genesis.json` dentro da pasta ethereum contendo:
```sh          
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
                          "": {
                            "balance": "1000"
                          },
                          "": {
                            "balance": "2000"
                          }
                           "": {
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
```

baixar a imagem do ethereum
`sudo docker pull ethereum/client-go:release-1.10`

criar container e executar a imagem baixada 
`sudo docker run -d --name ethereum-node -v $HOME/ethereum:/root -p 8545:8545 -p 8544:8544 -p 30301:30301 -p 30302:30302 -it --entrypoint=/bin/sh ethereum/client-go:release-1.10`

![criacao-conteiner](https://media.discordapp.net/attachments/848753904405446687/1187531396055564388/dockerpull.png?ex=659739cc&is=6584c4cc&hm=d1bfaf187822c72abe546a8d115e99c7ffb58977a953ea28f6bfc6f9d1fc6f52&=&format=webp&quality=lossless)

## Criação das contas
abra mais 3 terminais que serão 3 contas:
```
sudo docker exec -it ethereum-node sh`
cd /root
```

Para a criação das tres contas que a atividade solicitava, foi necessário executar o seguinte comando em cada terminal:

conta 1:`geth account new --datadir ~/ponzi1` 
conta 2:`geth account new --datadir ~/ponzi2` 
conta 3:`geth account new --datadir ~/ponzi3` 


![contas](https://media.discordapp.net/attachments/848753904405446687/1187531268250943548/accCreation.png?ex=659739ad&is=6584c4ad&hm=5c9808221d50f52fc07b43a199467ca373c8554f83a8ca1f0a93e902a848bed8&=&format=webp&quality=lossless&width=622&height=701)

## Inicialização
Após a criação das contas, guarde as chaves em algum lugar e atualize o `genesis.json` com as chaves.
```sh          
              "alloc": {
                          "0x14A893287722D2ea7050f66B4e3421feB5e631d1": {
                            "balance": "1000"
                          },
                          "0x0D77996eAd0C9C0fbFdE5dB550D808779577b1e4": {
                            "balance": "2000"
                          }
                           "0x49e4523A16A3E4E9A4C7D1150220E974FedCE5Da": {
                            "balance": "3000"
                          }
              },
```

conta 1:`geth --datadir /root/ponzi1/ init genesis.json`
conta 2:`geth --datadir /root/ponzi2/ init genesis.json`
conta 3:`geth --datadir /root/ponzi3/ init genesis.json`

![inicialização](https://media.discordapp.net/attachments/848753904405446687/1187531487571095652/initgenesis.png?ex=659739e1&is=6584c4e1&hm=28760e89dd22cb3495a1c42c6c64c5fd70daeab5965388958434c12f26ffc2f7&=&format=webp&quality=lossless&width=622&height=701)

## Iniciar a rede

conta 1:
```sh 
`geth --datadir ~/ponzi1 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8547 --allow-insecure-unlock console`
```
conta 2:
```sh 
`geth --datadir ~/ponzi2 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8546 --port 30302 --http.port 8544 --allow-insecure-unlock console`
```
conta 3:
```sh 
`geth --datadir ~/ponzi3 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8548 --port 30500 --http.port 30501 --allow-insecure-unlock console`
```

## Verificar saldo

conta 1: `eth.getBalance("0x14A893287722D2ea7050f66B4e3421feB5e631d1")`
conta 2: `eth.getBalance("0x0D77996eAd0C9C0fbFdE5dB550D808779577b1e4")`
conta 3: `eth.getBalance("0x49e4523A16A3E4E9A4C7D1150220E974FedCE5Da")`

![saldo inicial conta 1](https://media.discordapp.net/attachments/848753904405446687/1187531604235649114/balance1.png?ex=659739fd&is=6584c4fd&hm=134622de1b6ef91d48c811c760290874ac5561486b7f40b53226f33852274d26&=&format=webp&quality=lossless)
![saldo inicialconta 2](https://media.discordapp.net/attachments/848753904405446687/1187531604512493699/balance2.png?ex=659739fd&is=6584c4fd&hm=8ede04e489b72591434aed66d63612d1b8c9b05542932ca79c4511b2a7415961&=&format=webp&quality=lossless)
(esqueci de tirar print da conta 3 antes de minerar)

## Minerar
`miner.start(10)`

espere um momento até começar a minerar

`miner.stop()`

![mineração](https://media.discordapp.net/attachments/853422218222370818/1187520739679682640/image.png?ex=65972fdf&is=6584badf&hm=511ad914c06ea287f011daf8be45dae810f96b698cd497d218068ce404c90165&=&format=webp&quality=lossless&width=716&height=701)

## Saldo após mineração
conta 1:
![saldo mineração conta 1](https://media.discordapp.net/attachments/848753904405446687/1187547112062324786/balance1mine.png?ex=6597486f&is=6584d36f&hm=d7c9104ce4d6e07ce80e169266bc060b48abee0bf53974ab2a1a14b11cf22764&=&format=webp&quality=lossless)

conta 2:

![saldo mineração conta 2](https://media.discordapp.net/attachments/848753904405446687/1187547136800342137/balance2mine.png?ex=65974874&is=6584d374&hm=3a59fbda9014a423a8d2e1dcc6a8a3fb021c3d51f8777282edd57fce60b3d9fd&=&format=webp&quality=lossless)

conta 3:
![saldo mineração conta 3](https://media.discordapp.net/attachments/848753904405446687/1187547168656076840/balance3mine.png?ex=6597487c&is=6584d37c&hm=e6e61ab077e176ce998b0a8a7c16520a28d37747d6821759d91b6ffb6ddcdd9d&=&format=webp&quality=lossless)

## Transações
para fazer uma transação, primeiro é nescessario desbloquear as contas.
conta 1: `personal.unlockAccount("0x14A893287722D2ea7050f66B4e3421feB5e631d1")`
conta 2: `personal.unlockAccount("0x0D77996eAd0C9C0fbFdE5dB550D808779577b1e4")`
conta 3: `personal.unlockAccount("0x49e4523A16A3E4E9A4C7D1150220E974FedCE5Da")`

![habilitar transação](https://media.discordapp.net/attachments/848753904405446687/1187548862479597688/unlockAcc.png?ex=65974a10&is=6584d510&hm=c2bfd06d6d4983ea2527dcc805f74b5b7c2f06b7cda4015f68e8ab9fc2d21923&=&format=webp&quality=lossless)

### Transação 1
envia 111 da conta 1 para a conta 2.
```sh
eth.sendTransaction({from:"0x14A893287722D2ea7050f66B4e3421feB5e631d1", to:"0x0D77996eAd0C9C0fbFdE5dB550D808779577b1e4", value:111, gas:21000})
```
![txpool](https://media.discordapp.net/attachments/848753904405446687/1187551750576689162/transaction1.png?ex=65974cc0&is=6584d7c0&hm=65176a3e3f4e4d68688d95014f31c0f6412213724f246cbbf9cea3a8bc882a6f&=&format=webp&quality=lossless)
verificar status
`txpool.status`
![txpool](https://media.discordapp.net/attachments/848753904405446687/1187550216610643978/txpool.png?ex=65974b53&is=6584d653&hm=c9459d03f278b531764010f5876c26217a872079d21f13f4d0ec24f0d8d8908d&=&format=webp&quality=lossless)

mineirar para efetivar a transação
`miner.start(10)`
`miner.stop()`

verificar status após mineiração
`txpool.status`
![txpool](https://media.discordapp.net/attachments/848753904405446687/1187552457782468648/txpool2.png?ex=65974d69&is=6584d869&hm=af1d3c56f7362e12aee60a03658ce50fc5771abe62f5c846de643072eca1b50f&=&format=webp&quality=lossless)
conta 1 após transação
![txpool](https://media.discordapp.net/attachments/848753904405446687/1187552757226414120/balance1trans.png?ex=65974db0&is=6584d8b0&hm=ed3b5e1db82d3581d78dad0543842c90b5d567ebbaee6156b5b77c132956e96f&=&format=webp&quality=lossless)
conta 2 após transação
![txpool](https://media.discordapp.net/attachments/848753904405446687/1187553109451489290/balance2trans.png?ex=65974e04&is=6584d904&hm=12f807e26079c4975d2a13991521e53f03a4c50dd5baf2b92c4c01271756bdb6&=&format=webp&quality=lossless)

### Transação 2
envia 222 da conta 2 para a conta 3.
```sh
eth.sendTransaction({from:"0x0D77996eAd0C9C0fbFdE5dB550D808779577b1e4", to:"0x49e4523A16A3E4E9A4C7D1150220E974FedCE5Da", value:222, gas:21000})
```
conta 3 após transação
![txpool](https://media.discordapp.net/attachments/848753904405446687/1187553592622727178/balance3trans.png?ex=65974e78&is=6584d978&hm=12ba1fbf07cfec1326b61117a2c2e071d19d0ca9116917dfd66781eb36daf064&=&format=webp&quality=lossless)
## Novidades
nas transações foi definido um preço para o gas que foi de 21000, mas o valor do gas pode ser definido pelo codigo:
`miner.setGasPrice(valor do Gas)`

## Git
![git](https://media.discordapp.net/attachments/848753904405446687/1187555509507723274/image.png?ex=65975041&is=6584db41&hm=b54d8b2d1745c9bf9f47b884104a2db5901925ca2bd9172024f626e0b3a7ca81&=&format=webp&quality=lossless&width=570&height=701)

