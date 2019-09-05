FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache R R-dev                                      && \
    echo "install.packages('IRkernel', repos='http://cran.us.r-project.org')" | tee -a install.R && \
    echo "IRkernel::installspec(user = FALSE)" | tee -a install.R && Rscript install.R           && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf && rm -rf /root/.[acplnw]*            && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf