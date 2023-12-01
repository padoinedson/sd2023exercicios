#### Aluno: Gabriel Bauer Vieira

### Requisitos
- Docker
- Ferramenta para fazer requisições HTTP (postman de preferência)

### Passos para execução
#### 1. Executar o comando para criar os containers
  ``` sh
      docker-compose up -d
  ```

#### 2. Após a criação do container, aguarde uns minutos (ou horas, dependendo do hardware) para que a DAG seja criada.
![Dag](images/image-9.png)

#### 3. Verificar se a conexão RPC está ativa
![Conexão via RPC](images/image.png)

#### 4. Testar os diferentes Endpoints ([arquivo de rotas](Ethereum-Private-Network.postman_collection.json))

### Novidades
- Segurança nas contas (não liberamos o acesso full para todas as contas)
- Conexão via RPC (possibilita executar métodos via requisição ou sistemas web externos)
- Mineração com antigo algoritmo de consenso POW


### Prints
1. Containers
   ![Containers](images/image-1.png)

2. Criação de nova conta
   ![Nova conta](images/image-2.png)

3. Verificação de saldo da conta nova
   ![Saldo conta nova](images/image-3.png)

4. Saldo conta de mineração
   ![Saldo conta de mineração](images/image-4.png)

5. Envio de transação entre duas contas
   ![Transação](images/image-5.png)

6. Execução do minerador
   ![Minerador](images/image-6.png)

7. Dados da transação
   ![Transação Dados](images/image-7.png)

8. Saldo da conta que recebeu a transação
   ![Saldo conta](images/image-8.png)