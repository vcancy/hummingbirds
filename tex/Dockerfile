FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk update && apk upgrade && apk add --no-cache texlive texlive-xetex texmf-dist-langchinese                         \
    texmf-dist-science texmf-dist-bibtexextra texmf-dist-fontsextra texmf-dist-latexextra texmf-dist-pictures         && \
    pip install --no-cache-dir jupyterlab_latex && jupyter serverextension enable --sys-prefix jupyterlab_latex       && \
    jupyter labextension install @jupyterlab/latex && npm cache clean -f && find /usr/lib/python3.* -name __pycache__ |  \
    xargs rm -rf && rm -rf /root/.[acplnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf