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
