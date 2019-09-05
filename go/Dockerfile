FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add go zeromq-dev libzmq && go get -u github.com/gopherdata/gophernotes  && \
    cp /root/go/bin/gophernotes /usr/local/bin && mkdir -p /root/.local/share/jupyter/kernels/gophernotes     && \
    cp /root/go/src/github.com/gopherdata/gophernotes/kernel/* /root/.local/share/jupyter/kernels/gophernotes && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf                                                    && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acpnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf