#!/bin/bash

containers=("ethereum_4245_node1_1" "ethereum_4245_node2_1" "ethereum_4245_node3_1" "ethereum_4245_node4_1")

for container in "${containers[@]}"; do
    echo "Parando mineração no contêiner $container..."
    sudo docker exec -i "$container" sh -c 'echo "miner.stop()" | geth attach ipc:/ethereum/geth.ipc'
done
