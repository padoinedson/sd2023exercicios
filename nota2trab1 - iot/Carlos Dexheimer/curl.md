#### Comando para criar uma conexão JDBC com o postgres
curl -X POST -H "Content-Type: application/json" --data '{
  "name": "jdbc-source-connector",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "connection.url": "jdbc:postgresql://postgres:5432/teste_db",
    "connection.user": "teste",
    "connection.password": "testesenha",
    "mode": "incrementing",
    "incrementing.column.name": "id",
    "topic.prefix": "",
    "table.whitelist": "[tabelas que o kafka irá escutar]",
    "key.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "key.converter.schemas.enable": "false",
    "value.converter.schemas.enable": "false"
  }
}' http://localhost:8083/connectors

#### Comando para deletar o connector
curl -X DELETE http://localhost:8083/connectors/jdbc-source-connector