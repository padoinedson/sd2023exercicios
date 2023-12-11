FROM alpine:latest

RUN apk --no-cache add sqlite

# Copie o script SQL para inicializar o banco de dados
COPY script.sql /docker-entrypoint-initdb.d/

