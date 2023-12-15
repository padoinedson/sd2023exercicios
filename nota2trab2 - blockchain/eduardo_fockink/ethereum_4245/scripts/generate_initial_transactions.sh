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
