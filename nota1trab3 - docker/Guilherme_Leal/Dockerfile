# Inicia com a imagem do Ubuntu
FROM ubuntu:latest

# Adiciona o mantenedor
LABEL maintainer="guilhermeizidroleal@gmail.com"

# Instala alguns pacotes necessarios
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    wget \
    tar

# Define as variaveis de ambiente do Java
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Busca o Tomcat
RUN mkdir /usr/local/tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.31/* /usr/local/tomcat/

# Define as variaveis de ambiente do Tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Define a porta 8080
EXPOSE 8080

# Inicializa Tomcat
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]