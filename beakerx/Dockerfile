FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk add bash zip maven && curl -s https://get.sdkman.io | bash && \
    rm -rf /root/.[abcplnwz]* && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

SHELL ["/bin/bash", "-c"]

RUN source /root/.sdkman/bin/sdkman-init.sh && sdk install kotlin 1.3.50 && sdk install scala 2.13.0 && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf && rm -rf /root/.[abcplnwz]*              && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

SHELL ["/bin/sh", "-c"]

ENV PATH /root/.sdkman/candidates/scala/2.13.0/bin:/root/.sdkman/candidates/kotlin/1.3.50/bin:$PATH

RUN echo -e "\nexport KOTLIN_HOME=/root/.sdkman/candidates/kotlin/1.3.50" | tee -a /etc/profile && \
    echo -e "export PATH=\$KOTLIN_HOME/bin:\$PATH"                        | tee -a /etc/profile && \
    echo -e "\nexport SCALA_HOME=/root/.sdkman/candidates/scala/2.13.0"   | tee -a /etc/profile && \
    echo -e "export PATH=\$SCALA_HOME/bin:\$PATH"                         | tee -a /etc/profile

RUN apk update && apk upgrade && apk add --no-cache python3-dev    && \
    pip3 install beakerx py4j ipywidgets pandas && beakerx install && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf         && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf