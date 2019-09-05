FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache bash                                                    && \
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz        && \
    tar zxvf spark-2.4.3-bin-hadoop2.7.tgz && mv /root/notebook/spark-2.4.3-bin-hadoop2.7 /root/spark       && \
    pip3 install toree && jupyter toree install --spark_home=/root/spark                                    && \
    sed -i "s/Apache Toree - Scala/Toree/g" /usr/local/share/jupyter/kernels/apache_toree_scala/kernel.json && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf                                                  && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /root/notebook/*

RUN echo -e "\nexport SPARK_HOME=/root/spark"     | tee -a /etc/profile && \
    echo -e "export PATH=\$SPARK_HOME/bin:\$PATH" | tee -a /etc/profile

CMD supervisord -c /root/.supervisor/supervisord.conf