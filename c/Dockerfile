FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN pip3 install jupyter-c-kernel && install_c_kernel && ln -snf /root/notebook /usr/include/notebook && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf && rm -rf /root/.[acpnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

RUN git clone https://github.com/goofts/Silverbullets.git && cd Silverbullets && cp *.h /usr/include/ && \
    cd .. && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/* /root/.[abcpnw]*

CMD supervisord -c /root/.supervisor/supervisord.conf
