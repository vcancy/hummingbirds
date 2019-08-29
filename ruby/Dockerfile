FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache libzmq czmq-dev ruby ruby-dev ruby-rdoc                     && \
    gem install cztop iruby && iruby register && rm /root/.local/share/jupyter/kernels/ruby/kernel.json         && \
    echo -e  '{"argv":["/usr/bin/iruby","kernel","{connection_file}"],"display_name":"Ruby","language":"ruby"}' |  \
    tee  -a  /root/.local/share/jupyter/kernels/ruby/kernel.json && find /usr/lib/python3.* -name __pycache__   |  \
    xargs rm -rf && rm -rf /root/.[acpnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf