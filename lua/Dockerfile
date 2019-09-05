FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache python3-dev lua && pip3 install ilua && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf                               && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf