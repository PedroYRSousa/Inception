# 3.16 é a penultina versão antes do 'stable' que é o 3.17
FROM alpine:3.16

# Envia essas variaveis de ambiente para dentro da imagem
ARG DB_NAME \
    DB_USER \
    DB_PASS

# instala a  madriadb
RUN apk update && apk add --no-cache mariadb mariadb-client

# Prepara a pasta do banco de dados
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

# Perar para receber as configurações do banco de dado
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expoe a porta 3306 padrão do mysql
EXPOSE 3306

# Envia o arquivo create_db.sh para um local onde a imagem consegue executar
COPY requirements/mariadb/conf/create_db.sh .
# executa o arquivo create_db.sh e o remove
RUN sh create_db.sh && rm create_db.sh

USER mysql
# Executa o banco de dados
CMD ["/usr/bin/mysqld", "--skip-log-error"]
