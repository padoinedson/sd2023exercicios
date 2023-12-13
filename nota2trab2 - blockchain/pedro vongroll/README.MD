# PEDRO HENRIQUE VON GROLL

# PASSO A PASSO BLOCKCHAIN
Comecei criando meu diretótio utilizando o seguinte comando:

`$mkdir ethereum`

Após criar o diretório fiz o download da imagem do Docker no terminal, que é associada ao cliente Go do Ethereum.

`$sudo docker pull ethereum/client-go:release-1.10`

Realizado o download da imagem, utilizei o seguinte comando para criar e executar um conteiner Docker, com o nome ethereum-node com base na imagem baixada.

`$ sudo docker run -d --name ethereum-node -v $HOME/ethereum:/root -p 8545:8545 -p 8544:8544 -p 30301:30301 -p 30302:30302 -p 30303:30303 -p 30304:30304 -it --entrypoint=/bin/sh ethereum/client-go:release-1.10`

![criacao-conteiner](https://github.com/padoinedson/sd2023exercicios/assets/141967871/96b553dc-8b67-42da-abcd-ae61ae70d18e)


Criado o conteiner abri mais três terminais que vão ser respecitvos as três contas solicitadas para atividade, em cada terminal executei os seguintes comandos:

`$sudo docker exec -it ethereum-node sh` - ao executar esse comando você entra em um ambiente de shell dentro do conteiner.

`$ cd /root` -  comando para mudar o diretório de trabalho atual para o root.

Para a criação das tres contas que a atividade solicitava, foi necessário executar o seguinte comando em cada terminal:

`$geth account new --datadir ~/vongroll1` 
`$geth account new --datadir ~/vongroll2` 
`$geth account new --datadir ~/vongroll3` 

**PRINTS DOS COMANDOS CRIANDO SUAS RESPECTIVAS CONTAS**

![conta1](https://github.com/padoinedson/sd2023exercicios/assets/141967871/c2ccfb78-7472-47c7-b85e-d703fa4f0f6c)
![conta2](https://github.com/padoinedson/sd2023exercicios/assets/141967871/a0271c71-404c-46cc-aa85-56d4139dcb87)
![conta3](https://github.com/padoinedson/sd2023exercicios/assets/141967871/c8f26a89-1091-40a4-846c-76dc808cec5f)

Após a criação das três contas, anotei as chaves de cada uma para criar o arquivo com o nome genesis.json dentro da pasta ethereum, que vai ser usado para definir as configurações iniciais da blockchain, contendo três contas com saldos específicos.

![arquivo-genesis](https://github.com/padoinedson/sd2023exercicios/assets/141967871/d903f95e-2a8e-442d-9745-8467de9ef928)

Configurado o arquivo genesis com as respectivas chaves das contas, utilizei o comando listado a abaixo para inicializar um diretório de dados do cliente, com base no arquivo genesis. Este é um passo muito importante ao configurar uma nova rede de Ethereum.

**ESTE COMANDO DEVE SER RODADO EM CADA TERMINAL COM SUA RESPECTIVA CONTA** 

`$geth --datadir /root/vongroll1/ init genesis.json`
`$geth --datadir /root/vongroll2/ init genesis.json`
`$geth --datadir /root/vongroll3/ init genesis.json`

**APÓS INICIALIZAÇÃO**

![inicialização](https://github.com/padoinedson/sd2023exercicios/assets/141967871/7280b41c-9c85-4881-926d-bd5ba6ed3d7d)

Realizado estes passos, utilizei o próximo comando para que o Geth fosse iniciado com as configurações especificadas, permitindo assim a interação com a blockchain.

**CONTA 1**

`$geth --datadir ~/vongroll1 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8547 --allow-insecure-unlock console`

**CONTA 2**

`$geth --datadir ~/vongroll2 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8546 --port 30302 --http.port 8544 --allow-insecure-unlock console`

**CONTA 3**

`$geth --datadir ~/vongroll3 --networkid 2023 --http --http.api 'txpool,eth,net,web3,personal,admin,miner' --http.corsdomain '*' --authrpc.port 8548 --port 30500 --http.port 30501 --allow-insecure-unlock console`

Meu próximo passo foi verificar os saldos das contas que havia criado, para fins de conferência, então utilizei o seguinte comando:

**CONFERENCIA DE SALDO INICIAL DAS 3 CONTAS**

`$eth.getBalance("0xE307C612074670B7F3f0e1294deA7a693Cbc1050")` - conta 1
`$eth.getBalance("0xf85767fe7bd3d4ba0d122ea4bfdea7652c84e04e")` - conta 2
`$eth.getBalance("0xc6619B5951b462BE2Fe403535916feFF32C9C0e0")` - conta 3

![saldo inicial](https://github.com/padoinedson/sd2023exercicios/assets/141967871/5146709b-9c92-4cac-926c-409acbb3b803)

Após ter verificado que os saldos das contas estavam corretos como solicitado, comecei o processo de mineração. Utiizei o segunte comando para inicializar:

`$miner.start(10)`

Ele levou uns minutinhos até iniciar o processo de mineração, mas depois que foi dado inicio, logo utilizei o comando para encerrar a mineração.

`$miner.stop()`

![mineração](https://github.com/padoinedson/sd2023exercicios/assets/141967871/925175e6-987e-496e-bf29-cc6c23dc0cc8)

Encerrando então o processo de mineração verifiquei novamente os saldos das contas, para conferir se tinha minerado de forma correta.

`$eth.getBalance("0xE307C612074670B7F3f0e1294deA7a693Cbc1050")` - conta 1

![saldo mineração conta 1](https://github.com/padoinedson/sd2023exercicios/assets/141967871/a426f360-f40b-4340-bdac-85a401b262ba)

`$eth.getBalance("0xf85767fe7bd3d4ba0d122ea4bfdea7652c84e04e")` - conta 2

![saldo mineração conta 2](https://github.com/padoinedson/sd2023exercicios/assets/141967871/afb1667f-d3dc-4295-a278-1b7b5e72a566)

`$eth.getBalance("0xc6619B5951b462BE2Fe403535916feFF32C9C0e0")` - conta 3

![saldo mineração conta 3](https://github.com/padoinedson/sd2023exercicios/assets/141967871/61a52af6-4ab5-4236-829f-532a3bd465a8)

Após conferir os saldos das contas, dei inicio ao processo de transação entre contas, para isso o primeiro passo foi habilitar as transações em cada conta, utilizando o seguinte comando em cada terminal:

`$personal.unlockAccount("0xe307c612074670b7f3f0e1294dea7a693cbc1050")`- conta 1
`$personal.unlockAccount("0xf85767fe7bd3d4ba0d122ea4bfdea7652c84e04e")`- conta 2 
`$personal.unlockAccount("0xc6619b5951b462be2fe403535916feff32c9c0e0")`- conta 3

![habilitar transação](https://github.com/padoinedson/sd2023exercicios/assets/141967871/af68b364-2dc6-434c-880f-5a28e745996f)

Possuindo as contas habilitadas para realizar transações fiz a primeira transação, sendo ela da conta 1 para a conta 2 no valor de 111, utilizei um comando que que vai possibilitar adicionar uma tag, que no caso eu utilizei a "tag= mineracao", uma descrição, escrevi "transação entre contas" e por fim vai armazenar o número do bloco. 

```var numeroDoBloco = eth.blockNumber;
eth.sendTransaction({
  from: "sua_chave",
  to: "chave_destino",
  value: 111,
  gas: 50000,
  data: web3.toHex("sua_tag:sua_descricao:" + numeroDoBloco)
});
```
Realizada a transação, verifiquei o status para conferir se a mesma havia ficado pendente, então tive o seguinte retorno:

**TRANSAÇÃO 1**

![transação 1](https://github.com/padoinedson/sd2023exercicios/assets/141967871/9455e7d8-e361-4fc1-85ba-0f3113725242)

Visto que tinha ficado pendente realizei novamente o processo de mineração para que fosse processado a transação. Após alguns segundos minerando, interrompi a mineração e verifiquei o status se ainda estava pendente, visto que não estava pendente, confirmei que a transação havido sido concluida com exito.

![transação 1 sem pendencia](https://github.com/padoinedson/sd2023exercicios/assets/141967871/a826ce77-bab5-41ed-b532-b696bb548bcd)

Como havia incluido mais informações a transação, queria verificar se os campos, TAG, descrição e Número do bloco, haviam sido armazenadas corretamente, então utilizando o seguinte comando, tive o seguinte retorno:

```// Substitua "SEU_HASH_DE_TRANSACAO" pelo hash real da sua transação
var hashDaTransacao = "0xb8461e319b226696d483570e35635905c0432c69b021b0435fd36cf006ab7633";

// Obtém a transação usando o hash
var transacao = eth.getTransaction(hashDaTransacao);

// Obtém o conteúdo codificado do campo 'data'
var dadosCodificados = transacao.input;

// Converte o conteúdo codificado para uma string legível
var dadosDecodificados = web3.toAscii(dadosCodificados);

console.log("Dados Decodificados:", dadosDecodificados);
```

![informações transação 1](https://github.com/padoinedson/sd2023exercicios/assets/141967871/ba56bb2a-86ac-40bb-bd5c-4ea918176c11)

Após realizado a transação verifiquei o saldo da conta 1, para confirmar se haviado sido concluida de fato.

**CONTA 1**

![saldo final conta 1](https://github.com/padoinedson/sd2023exercicios/assets/141967871/269d77c9-2f63-48c0-9ef8-8cbda4285dd7)


Partindo agora então para a segunda transação, o processo foi extamente o mesmo, a diferença ocorre na troca de chaves no comando de transação, altera as chaves da conta de saida e da conta de destino além de alterar o valor, já que a atividade solicita que a transação da conta 2 para a conta 3, seja no valor de 222

```var numeroDoBloco = eth.blockNumber;
eth.sendTransaction({
  from: "sua_chave",
  to: "chave_destino",
  value: 222,
  gas: 50000,
  data: web3.toHex("sua_tag:sua_descricao:" + numeroDoBloco)
});
```
![transação 2](https://github.com/padoinedson/sd2023exercicios/assets/141967871/b36b6aff-6993-4f42-827c-31b28a0433a5)

Seguindo os mesmos passos anteriores, verifiquei se ficou pendente a transação, iniciei e finalizei a mineração, no final consultei o saldo da conta para verificar se havia saido corretamente o valor.

**INFORMAÇÕES ADICIONAIS REFERENTE A TRANSAÇÃO 2**

![informações transação 2](https://github.com/padoinedson/sd2023exercicios/assets/141967871/f79dfb55-312d-4076-b6e6-190935762df2)

Após realizado a transação verifiquei o saldo da conta 2, para confirmar se haviado sido concluida de fato.

![saldo final conta 2](https://github.com/padoinedson/sd2023exercicios/assets/141967871/34d7f512-fe99-4be0-8578-1a27f218560c)


Finalizando todas as transações solicitadas, verifiquei o saldo final das 3 contas que haviam sido criadas, para verificar se tinha ocorrido tudo certo com a transações.

**CONFERÊNCIA SALDO FINAL DAS CONTAS**

![saldo final conta 1](https://github.com/padoinedson/sd2023exercicios/assets/141967871/4cdcda99-5299-4822-b9a4-ed19f209c684)

![saldo final conta 2](https://github.com/padoinedson/sd2023exercicios/assets/141967871/34d7f512-fe99-4be0-8578-1a27f218560c)

![saldo final conta 3](https://github.com/padoinedson/sd2023exercicios/assets/141967871/9df407b5-4f2a-40e0-8c76-f9b1fe8c4323)



# NOVIDADE EM RELAÇÃO AO EXEMPLO DA AULA

Para a questão da novidade, o que eu fiz de diferente foi que no momento de realizar a transação entre contas, fosse possível adicionar dados a transação, seriam eles a TAG, descrição e também armazenar o número do bloco. O comando utiliazado para realizar essa transação é o seguinte:

```var numeroDoBloco = eth.blockNumber;
eth.sendTransaction({
  from: "sua_chave",
  to: "chave_destino",
  value: 111,
  gas: 50000,
  data: web3.toHex("sua_tag:sua_descricao:" + numeroDoBloco)
});
```
**COMO PODEMOS OBSERVAR NA PRIMEIRA TRANSAÇÃO REALIZADA ENTRE AS CONTAS**

![inserção de informações na transação](https://github.com/padoinedson/sd2023exercicios/assets/141967871/6ad3568b-152e-48ec-9d5f-a25df2a899ed)

Após realizada a transação, através do hash podemos verificar as informações inseridas no momento da transação.

```// Substitua "SEU_HASH_DE_TRANSACAO" pelo hash real da sua transação
var hashDaTransacao = "0xb8461e319b226696d483570e35635905c0432c69b021b0435fd36cf006ab7633";

// Obtém a transação usando o hash
var transacao = eth.getTransaction(hashDaTransacao);

// Obtém o conteúdo codificado do campo 'data'
var dadosCodificados = transacao.input;

// Converte o conteúdo codificado para uma string legível
var dadosDecodificados = web3.toAscii(dadosCodificados);

console.log("Dados Decodificados:", dadosDecodificados);
```
**VERIFICANDO AS INFORMAÇÕES ADICIONADAS NA TRANSAÇÃO ATRAVÉS DO HASH**

![verificação de informações da transação](https://github.com/padoinedson/sd2023exercicios/assets/141967871/9727ee37-998c-4a12-9154-eeb64a370ad2)

# ENVIO DOS PRINTS REFERENTE AO GIT ADD, GIT COMMIT E GIT PUSH

GIT ADD e GIT COMMIT

![git add](https://github.com/padoinedson/sd2023exercicios/assets/141967871/f8dab70a-8e9e-45f0-a408-1e95da717f4d)

GIT PUSH

![git push](https://github.com/padoinedson/sd2023exercicios/assets/141967871/4bce4aeb-1bb7-4ad4-a7ad-7532ae7e42fa)