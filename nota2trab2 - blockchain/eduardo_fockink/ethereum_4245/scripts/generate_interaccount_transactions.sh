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
