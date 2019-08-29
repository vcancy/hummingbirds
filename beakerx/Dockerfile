FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk add bash zip maven && ln -snf /bin/bash /bin/sh && curl -s https://get.sdkman.io | bash    && \
    bash /root/.sdkman/bin/sdkman-init.sh && sdk install kotlin 1.3.50 && sdk install scala 2.13.0 && \
    ln -snf /bin/busybox /bin/sh && find /usr/lib/python* -name __pycache__ |  xargs rm -rf        && \
    rm -rf /root/.[abcplnwz]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

ENV PATH /root/.sdkman/candidates/scala/2.13.0/bin:/root/.sdkman/candidates/kotlin/1.3.50/bin:$PATH

RUN echo -e "\nexport KOTLIN_HOME=/root/.sdkman/candidates/kotlin/1.3.50" | tee -a /etc/profile && \
    echo -e "export PATH=\$KOTLIN_HOME/bin:\$PATH"                        | tee -a /etc/profile && \
    echo -e "\nexport SCALA_HOME=/root/.sdkman/candidates/scala/2.13.0"   | tee -a /etc/profile && \
    echo -e "export PATH=\$SCALA_HOME/bin:\$PATH"                         | tee -a /etc/profile

RUN apk update && apk upgrade && apk add --no-cache python3-dev    && \
    pip3 install beakerx py4j ipywidgets pandas && beakerx install && \
    find /usr/lib/python3.* -name __pycache__ | xargs rm -rf       && \
    rm -rf /root/.[acplnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf
