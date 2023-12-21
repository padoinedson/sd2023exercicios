FROM influxdb

# Expor a porta padrão do InfluxDB
EXPOSE 8086

# Copiar o script de inicialização
COPY init-influxdb.sh /usr/local/bin/

# Tornar o script executável
RUN chmod +x /usr/local/bin/init-influxdb.sh

# Executar o script quando o contêiner for iniciado
CMD ["init-influxdb.sh"]
