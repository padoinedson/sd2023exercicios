-- script.sql

-- Criação de uma tabela de exemplo
CREATE TABLE brasileirao (
    id INTEGER PRIMARY KEY,
    time TEXT,
    titulo INTEGER
);

-- Inserção de dados na tabela
INSERT INTO brasileirao (time, titulo) VALUES ('Internacional', 55), ('Gremio', 30);

