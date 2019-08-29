FROM goofts/hummingbirds

MAINTAINER goofts loking.zhao.moshang@icloud.com

RUN apk upgrade && apk add --no-cache linux-headers libarchive-tools gtk-update-icon-cache tar gfortran perl python && \
    git clone https://github.com/goofts/Julia.git && cd Julia && git pull && make && make install && cd ../         && \
    cp -R /root/notebook/Julia/julia-* /root/julia && find /usr/lib/python3.* -name __pycache__ | xargs rm -rf      && \
    rm -rf /root/.[acplnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

ENV PATH /root/julia/bin:$PATH

RUN echo -e "\nexport JULIA_HOME=/root/julia"     | tee -a /etc/profile && \
    echo -e "export PATH=\$JULIA_HOME/bin:\$PATH" | tee -a /etc/profile

RUN echo -e  'using Pkg\nPkg.add("IJulia")\nPkg.build("IJulia")' | tee -a install.jl && julia install.jl && \
    sed  -i  "s/Julia 1.4.0-DEV/Julia/g" /root/.local/share/jupyter/kernels/julia-1.4/kernel.json        && \
    rm   -rf /root/.[acpnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*

CMD supervisord -c /root/.supervisor/supervisord.conf
