FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN pip3 install jupyter-c-kernel && install_c_kernel && ln -snf /root/notebook /usr/include/notebook && \
    git clone https://github.com/goofts/Silverbullets.git && cd Silverbullets && cp *.h /usr/include/ && \
    cd /root/notebook && find /usr/lib/python* -name __pycache__ | xargs rm -rf                       && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acpnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf