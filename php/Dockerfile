FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk add php7 php7-tokenizer php7-mbstring php7-openssl php7-zmq php7-json php7-phar php7-iconv php7-cgi && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer            && \
    wget https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.signed.phar.pubkey       && \
    wget https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.signed.phar              && \
    composer require react/zmq && php jupyter-php-installer.signed.phar install && apk upgrade              && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf && rm -rf /root/.[acplnw]*                       && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf
