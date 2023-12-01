# Use uma imagem base com o Tomcat
FROM tomcat:latest

# Copie o WAR (Web Application Archive) da sua aplicação para o diretório webapps do Tomcat
COPY sample.war /usr/local/tomcat/webapps/

# Expor a porta padrão do Tomcat
EXPOSE 8080

# Comando a ser executado ao iniciar o contêiner
CMD ["catalina.sh", "run"]

