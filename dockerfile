FROM ubuntu:18.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y
RUN apt install mariadb-server wget nano apache2 unzip -y
RUN apt install php php-mbstring  php-xml php-common php-opcache php-cli php-gd php-curl php-mysqlnd -y
RUN cd /var/www/html && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.zip
RUN cd /var/www/html && unzip php*
RUN cd /var/www/html && mv phpMyAdmin-5.0.4-all-languages pma
COPY *DBNAME*.sql /var/www/
RUN echo -n ServerName bppk.info >> /etc/apache2/apache2.conf
COPY mysqlSI.sh /var/www/
RUN cd /etc/mysql/mariadb.conf.d/ && sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/g' 50-server.cnf
RUN cd /etc/apache2 &&  sed -i 's/Listen 443/Listen 444/g' ports.conf && sed -i 's/Listen 80/Listen 81/g' ports.conf
ENTRYPOINT ["/var/www/mysqlSI.sh"]
RUN cd /var/www && service mysql start &&  mysql -u USERNAME -pPASSWORD < *DBNAME*.sql
RUN service mysql start && mysql -u USERNAME -pPASSWORD -e "CREATE USER 'NEWuserNAME'@'%' IDENTIFIED BY 'PASSWORD';"
RUN service mysql start && mysql -u USERNAME -pPASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'NEWuserNAME'@'%';"
RUN service mysql start && mysql -u USERNAME -pPASSWORD -e "FLUSH PRIVILEGES;
