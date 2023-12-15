## Eduardo Fockink Silva - Dezembro de 2023

## Criando arquivos de **configuração** e scripts

1. **Criar diretório de trabalho:**

```bash
mkdir -p $HOME/ethereum_4245/{scripts,configs,nodes/{bootnode,node1,node2,node3,node4}}
cd $HOME/ethereum_4245
```

2. **Criando aquivos de configuração:**

### genesis.json

```bash
cat << 'EOF' > $HOME/ethereum_4245/configs/genesis.json
{
  "config": {
    "chainId": 4245,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "istanbulBlock": 0
  },
  "difficulty": "0x20000",
  "gasLimit": "0x2fefd8",
  "alloc": {
    "0x0000000000000000000000000000000000000001": {"balance": "10000"}
  },
  "coinbase": "0x0000000000000000000000000000000000000000",
  "nonce": "0x0000000000000042",
  "timestamp": "0x00",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "extraData": "0x",
  "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "gasUsed": "0x0",
  "number": "0x0"
}
EOF
```

### DockerfileBootnode

```bash
cat << 'EOF' > $HOME/ethereum_4245/configs/DockerfileBootnode
FROM ethereum/client-go:alltools-v1.10.5

RUN mkdir -p /ethereum
WORKDIR /ethereum

COPY configs/startbootnode.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
EOF
```

### DockerfileNode

```bash
cat << 'EOF' > $HOME/ethereum_4245/configs/DockerfileNode
FROM ethereum/client-go:v1.10.5

RUN mkdir -p /ethereum
WORKDIR /ethereum

COPY configs/startnode.sh /usr/local/bin/start.sh
COPY configs/genesis.json /root/genesis.json
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
EOF
```

### docker-compose.yml

```bash
cat << 'EOF' > $HOME/ethereum_4245/docker-compose.yml
version: '3.8'

services:
  bootnode:
    hostname: bootnode
    build:
      context: .
      dockerfile: configs/DockerfileBootnode
    volumes:
      - ./nodes/bootnode:/ethereum/
    stdin_open: true
    networks:
      - eth-net

  node1:
    build:
      context: .
      dockerfile: configs/DockerfileNode
    image: ethereum_4245_node:latest
    volumes:
      - ./nodes/node1:/ethereum/
    depends_on:
      - bootnode
    stdin_open: true
    networks:
      - eth-net

  node2:
    image: ethereum_4245_node:latest
    volumes:
      - ./nodes/node2:/ethereum/
    depends_on:
      - bootnode
    stdin_open: true
    networks:
      - eth-net

  node3:
    image: ethereum_4245_node:latest
    volumes:
      - ./nodes/node3:/ethereum/
    depends_on:
      - bootnode
    stdin_open: true
    networks:
      - eth-net

  node4:
    image: ethereum_4245_node:latest
    volumes:
      - ./nodes/node4:/ethereum/
    depends_on:
      - bootnode
    stdin_open: true
    networks:
      - eth-net

networks:
  eth-net:
    driver: bridge
EOF
```

### startnode.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/configs/startnode.sh
#!/bin/sh

DATADIR="/ethereum"
GENESIS_JSON="/root/genesis.json"
ENODE_BOOTNODE="enode://8c91e59c370b8837df400ea42b674edd056843c48dc5bac7cb7ba1fee03125fe0549cfecbb8754f83dde050ee87d3f04cdc23a350055b271f4d003b7c899d404@bootnode:30301"
PASSWORD='123'

if [ ! -d "$DATADIR/geth/chaindata" ]; then
    geth --datadir $DATADIR init $GENESIS_JSON
fi

echo $PASSWORD > /tmp/account_password
geth account new --datadir /ethereum --password /tmp/account_password
rm /tmp/account_password

NEW_ACCOUNT=$(geth account list --datadir /ethereum | tail -n1 | awk '{print $3}' | tr -d '{}')

echo "personal.unlockAccount('$NEW_ACCOUNT', '$PASSWORD', 0)" > /tmp/unlock.js

geth --datadir $DATADIR \
     --networkid 4245 \
     --bootnodes $ENODE_BOOTNODE \
     --ipcpath $DATADIR/geth.ipc \
     --verbosity 3 \
     --preload "/tmp/unlock.js" \
     console

rm /tmp/unlock.js
EOF
sudo chmod +x ./configs/startnode.sh
```

### startbootnode.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/configs/startbootnode.sh
#!/bin/sh

BOOTNODE_KEY="0f33e8bfcc2acca9ad1296c4308507e5a25676339cc506cb9cb625129fd6f036"

bootnode --nodekeyhex=$BOOTNODE_KEY
EOF
sudo chmod +x ./configs/startbootnode.sh
```

3. **Criando scripts:**

### get_balance.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/scripts/get_balance.sh
#!/bin/bash

containers=("ethereum_4245_node1_1" "ethereum_4245_node2_1" "ethereum_4245_node3_1" "ethereum_4245_node4_1")

declare -a accounts

echo ""
for i in "${!containers[@]}"; do
    account=$(sudo docker exec -i "${containers[$i]}" geth attach ipc:/ethereum/geth.ipc --exec "eth.accounts[0]" | tr -d '"\n\r')
    accounts[$i]=$account
    balance=$(sudo docker exec -i "${containers[$i]}" geth attach ipc:/ethereum/geth.ipc --exec "eth.getBalance('$account')" | tr -d '"\n\r')
    echo "Conta $(($i + 1)): $account - Saldo: ${balance} Wei"
done
echo ""
EOF
sudo chmod +x ./scripts/get_balance.sh
```

### mine_start.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/scripts/mine_start.sh
#!/bin/bash

containers=("ethereum_4245_node1_1" "ethereum_4245_node2_1" "ethereum_4245_node3_1" "ethereum_4245_node4_1")

for container in "${containers[@]}"; do
    echo "Iniciando mineração no contêiner $container..."
    sudo docker exec -i "$container" sh -c 'echo "miner.start(1)" | geth attach ipc:/ethereum/geth.ipc'
done
EOF
sudo chmod +x ./scripts/mine_start.sh
```

### mine_stop.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/scripts/mine_stop.sh
#!/bin/bash

containers=("ethereum_4245_node1_1" "ethereum_4245_node2_1" "ethereum_4245_node3_1" "ethereum_4245_node4_1")

for container in "${containers[@]}"; do
    echo "Parando mineração no contêiner $container..."
    sudo docker exec -i "$container" sh -c 'echo "miner.stop()" | geth attach ipc:/ethereum/geth.ipc'
done
EOF
sudo chmod +x ./scripts/mine_stop.sh
```

### generate_initial_transactions.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/scripts/generate_initial_transactions.sh
#!/bin/bash

containers=("ethereum_4245_node1_1" "ethereum_4245_node2_1" "ethereum_4245_node3_1" "ethereum_4245_node4_1")

declare -a accounts

for i in "${!containers[@]}"; do
    account=$(sudo docker exec -i "${containers[$i]}" geth attach ipc:/ethereum/geth.ipc --exec "eth.accounts[0]" | tr -d '"\n\r')
    accounts[$i]=$account
done

transaction_1="eth.sendTransaction({from:'${accounts[3]}', to:'${accounts[0]}', value:1000, gas:21000});"
transaction_2="eth.sendTransaction({from:'${accounts[3]}', to:'${accounts[1]}', value:2000, gas:21000});"
transaction_3="eth.sendTransaction({from:'${accounts[3]}', to:'${accounts[2]}', value:3000, gas:21000});"
transaction_commands="$transaction_1 $transaction_2 $transaction_3"

echo ""
echo "Transações Iniciais:"
echo "Conta 1: $transaction_1"
echo "Conta 2: $transaction_2"
echo "Conta 3: $transaction_3"
echo ""

echo "Enviando Transações..."
transaction_commands="echo \"$transaction_commands\" | geth attach ipc:/ethereum/geth.ipc"
transaction_output=$(sudo docker exec -i ethereum_4245_node4_1 sh -c "$transaction_commands")

case "$transaction_output" in
    *"0x"*)
        echo "Transação enviada com sucesso. Hash da transação: $(echo "$transaction_output" | grep -o '0x[a-fA-F0-9]\{64\}')"
        ;;
    *)
        echo "Falha ao enviar transação."
        ;;
esac
echo ""
EOF
sudo chmod +x ./scripts/generate_initial_transactions.sh
```

### generate_interaccount_transactions.sh

```bash
cat << 'EOF' > $HOME/ethereum_4245/scripts/generate_interaccount_transactions.sh
#!/bin/bash

containers=("ethereum_4245_node1_1" "ethereum_4245_node2_1" "ethereum_4245_node3_1" "ethereum_4245_node4_1")

declare -a accounts

for i in "${!containers[@]}"; do
    account=$(sudo docker exec -i "${containers[$i]}" geth attach ipc:/ethereum/geth.ipc --exec "eth.accounts[0]" | tr -d '"\n\r')
    accounts[$i]=$account
done

transaction_1="eth.sendTransaction({from:'${accounts[0]}', to:'${accounts[1]}', value:111, gas:21000});"
transaction_2="eth.sendTransaction({from:'${accounts[1]}', to:'${accounts[2]}', value:222, gas:21000});"

echo ""
echo "Transferências entre Contas:"
echo "$transaction_1"
echo "$transaction_2"
echo ""

echo "Enviando Transação 1..."
transaction_commands="echo \"$transaction_1\" | geth attach ipc:/ethereum/geth.ipc"
transaction_output=$(sudo docker exec -i ethereum_4245_node1_1 sh -c "$transaction_commands")

case "$transaction_output" in
    *"0x"*)
        echo "Transação 1 enviada com sucesso. Hash da transação: $(echo "$transaction_output" | grep -o '0x[a-fA-F0-9]\{64\}')"
        ;;
    *)
        echo "Falha ao enviar transação."
        ;;
esac
echo ""

echo "Enviando Transação 2..."
transaction_commands="echo \"$transaction_2\" | geth attach ipc:/ethereum/geth.ipc"
transaction_output=$(sudo docker exec -i ethereum_4245_node2_1 sh -c "$transaction_commands")

case "$transaction_output" in
    *"0x"*)
        echo "Transação 2 enviada com sucesso. Hash da transação: $(echo "$transaction_output" | grep -o '0x[a-fA-F0-9]\{64\}')"
        ;;
    *)
        echo "Falha ao enviar transação."
        ;;
esac
echo ""
EOF
sudo chmod +x ./scripts/generate_interaccount_transactions.sh
```

O ambinte de trabalho está montado.
