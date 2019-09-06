FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add python2-dev py2-pip linux-headers python3-dev py3-pillow   && \
    pip2 install pyzmq ipykernel && pip3 install jupyterlab-dash==0.1.0a3 tqdm Cython numpy         && \
    python -m ipykernel install && pip3 install git+https://github.com/goofts/line_profiler.git     && \
    pip3 install dask[complete] dask_labextension && jupyter labextension install dask-labextension && \
    jupyter labextension install jupyterlab-dash@0.1.0-alpha.3                                      && \
    find /usr/lib/python* -name __pycache__ | xargs rm -rf && npm cache clean -f                    && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf
