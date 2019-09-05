FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk upgrade && apk add python2-dev py2-pip linux-headers && pip2 install pyzmq     && \
    npm install ijavascript -g --unsafe-perm && ijsinstall && npm cache clean -f       && \
    sed -i "s/ (Node.js)//g" /root/.local/share/jupyter/kernels/javascript/kernel.json && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf                             && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acpnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf