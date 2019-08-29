FROM alpine:edge

MAINTAINER goofts loking.zhao.moshang@icloud.com

# 创建目录
RUN mkdir -p /root/notebook /root/.supervisor/log /root/.SpaceVim.d                  && \
    mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension && \
    mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/terminal-extension         && \
    mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/fileeditor-extension       && \
    mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension

# 切换工作目录
WORKDIR /root/notebook

# 安装依赖包
RUN apk update && apk upgrade && apk add --no-cache binutils git curl make vim g++ openjdk8 nodejs python3               && \
    apk update && apk upgrade && apk add --no-cache npm py3-pyzmq py3-setuptools binutils-dev binutils-avr binutils-gold && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && pip3 install supervisor jupyterlab  && \
    sed -i "s/process.getuid && process.setuid/false/g" /usr/lib/node_modules/npm/node_modules/uid-number/uid-number.js  && \
    curl -sLf https://spacevim.org/install.sh | sed "s,=~ \\\.SpaceVim\\$,== \$HOME/.SpaceVim,g"                         |  \
    sh -s -- --install vim && jupyter notebook --generate-config && find /usr/lib/python3.* -name __pycache__            |  \
    xargs rm -rf && rm -rf /root/.[acplnw]* /tmp/* /var/tmp/* /var/cache/apk/* /root/notebook/*
    
# 配置环境变量
ENV PATH /usr/lib/jvm/default-jvm/bin:$PATH

RUN echo -e "\nexport JAVA_HOME=/usr/lib/jvm/default-jvm" | tee -a /etc/profile && \
    echo -e "export PATH=\$JAVA_HOME/bin:\$PATH"          | tee -a /etc/profile

# 编写 SpaceVim 配置文件
RUN echo -e "\n[options]"                                      | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e 'colorscheme = "gruvbox"'                          | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e 'colorscheme_bg = "dark"'                          | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "enable_guicolors = false"                         | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e 'statusline_separator = "nil"'                     | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e 'statusline_inactive_separator = "bar"'            | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "buffer_index_type = 4"                            | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "windows_index_type = 3"                           | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "enable_tabline_filetype_icon = false"             | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "enable_statusline_mode = false"                   | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "statusline_unicode_symbols = false"               | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "vimcompatible = true"                             | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "name='autocomplete'"                              | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e 'auto-completion-return-key-behavior = "complete"' | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e 'auto-completion-tab-key-behavior = "cycle"'       | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "name = 'shell'"                                   | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "default_position = 'top'"                         | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "default_height = 30"                              | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "\n[[custom_plugins]]"                             | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "name='goofts/syntastic'"                          | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "name='lang#c'"                                    | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /root/.SpaceVim.d/init.toml && \
    echo -e "name='lang#java'"                                 | tee -a /root/.SpaceVim.d/init.toml

# 编写 Jupyter 配置文件
RUN echo -e "\nc.NotebookApp.allow_root = True"                     | tee -a /root/.jupyter/jupyter_notebook_config.py  && \
    echo -e "c.NotebookApp.ip = '0.0.0.0'"                          | tee -a /root/.jupyter/jupyter_notebook_config.py  && \
    echo -e "c.NotebookApp.notebook_dir = u'/root/notebook'"        | tee -a /root/.jupyter/jupyter_notebook_config.py  && \
    echo -e "c.NotebookApp.open_browser = False"                    | tee -a /root/.jupyter/jupyter_notebook_config.py  && \
    echo -e "c.NotebookApp.port = 30129"                            | tee -a /root/.jupyter/jupyter_notebook_config.py  && \
    echo -e "c.NotebookApp.password = u'sha1:41e951df569e:f778d815bb1178a4f82dcfaa88a79b3c8e997451'"                    |  \
    tee  -a /root/.jupyter/jupyter_notebook_config.py && echo -e '{\n\t"enabled": true\n}'                              |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension/plugin.jupyterlab-settings          && \
    echo -e '{"codeCellConfig":'                                                                                        |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings                 && \
    echo -e '{"autoClosingBrackets":true,"fontFamily":"courier new","fontSize":16,"lineWrap":"on","lineNumbers":true},' |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings                 && \
    echo -e '"markdownCellConfig":'                                                                                     |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings                 && \
    echo -e '{"autoClosingBrackets":false,"fontFamily":"courier new","fontSize":16,"lineNumbers":true},'                |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings                 && \
    echo -e '"rawCellConfig":'                                                                                          |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings                 && \
    echo -e '{"autoClosingBrackets":false,"fontFamily":"courier new","fontSize":16,"lineNumbers":true}}'                |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings                 && \
    echo -e '{"editorConfig":{"fontFamily": "courier new","fontSize": 16,"lineNumbers":true}}'                          |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/fileeditor-extension/plugin.jupyterlab-settings                && \
    echo -e '{"fontFamily": "courier new","fontSize": 16,"shutdownOnClose": true}'                                      |  \
    tee  -a /root/.jupyter/lab/user-settings/@jupyterlab/terminal-extension/plugin.jupyterlab-settings
    
# 编写开机启动文件
RUN echo -e "[supervisord]"                                       | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "nodaemon=true"                                       | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "pidfile=/root/.supervisor/supervisord.pid"           | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "logfile=/root/.supervisor/log/supervisord.log"       | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "\n[program:jupyterlab]"                              | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "command=/usr/bin/jupyter lab"                        | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "stdout_logfile=/root/.supervisor/log/jupyterlab.log" | tee -a /root/.supervisor/supervisord.conf && \
    echo -e "stderr_logfile=/root/.supervisor/log/jupyterlab.log" | tee -a /root/.supervisor/supervisord.conf

# 开放管理端口
EXPOSE 30129

# 开机启动脚本
CMD supervisord -c /root/.supervisor/supervisord.conf