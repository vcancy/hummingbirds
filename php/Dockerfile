FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache apache2 php7 php7-apache2                            \
    php7-tokenizer php7-mbstring php7-openssl php7-zmq php7-json php7-phar php7-iconv php7-cgi        && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer      && \
    wget https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.signed.phar.pubkey && \
    wget https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.signed.phar        && \
    composer require react/zmq && php jupyter-php-installer.signed.phar install && chmod -R 777 /root && \
    find /usr/lib/python3.* -name __pycache__ | xargs rm -rf && rm -rf /root/.[acplnw]*               && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*
    
RUN sed  -i  "s:Listen 80:Listen 40826:g"                                        /etc/apache2/httpd.conf && \
    sed  -i  "s:/var/www/localhost/htdocs:/root/notebook:g"                      /etc/apache2/httpd.conf && \
    sed  -i  "s:DirectoryIndex index.html:DirectoryIndex index.html index.php:g" /etc/apache2/httpd.conf && \
    echo -e  "\nServerName localhost:40826"                             | tee -a /etc/apache2/httpd.conf
    
RUN echo -e "\n[program:apache2]"                                            | tee -a /root/.supervisor/supervisord.conf && \
    echo -e 'command=/usr/sbin/httpd -c "ErrorLog /dev/stdout" -DFOREGROUND' | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "stdout_logfile=/root/.supervisor/log/apache2.log"               | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "stderr_logfile=/root/.supervisor/log/apache2.log"               | tee -a /root/.supervisor/supervisord.conf
    
EXPOSE 40826

CMD supervisord -c /root/.supervisor/supervisord.conf