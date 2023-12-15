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
