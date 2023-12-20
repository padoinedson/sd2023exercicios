#!/bin/bash

# Esperar até que o serviço InfluxDB esteja disponível
until curl -G http://localhost:8086/ping 2>/dev/null; do
    echo "Aguardando o InfluxDB iniciar..."
    sleep 2
done

# Criar um banco de dados
influx -execute 'CREATE DATABASE meu_banco_de_dados'

# Usar o banco de dados criado
influx -database meu_banco_de_dados -execute '
    CREATE RETENTION POLICY "um_ano" ON "meu_banco_de_dados" DURATION 365d REPLICATION 1 DEFAULT
'

# Criar uma tabela
influx -database meu_banco_de_dados -execute '
    CREATE MEASUREMENT minha_medicao
'

# Inserir alguns dados de exemplo
influx -database meu_banco_de_dados -execute '
    INSERT minha_medicao,tag1=valor1,tag2=valor2 field1=42,field2=23
'
