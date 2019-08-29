FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache python3-dev lua               && \
    pip3 install --no-cache-dir ilua && find /usr/lib/python3.* -name __pycache__ |  \
    xargs rm -rf && rm -rf /root/.[acplnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf