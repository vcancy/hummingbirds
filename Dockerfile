FROM alpine:edge

MAINTAINER goofts loking.zhao.moshang@icloud.com

# 安装依赖包
RUN apk upgrade && apk add git curl make vim g++ openjdk8 nodejs python3 npm py3-pyzmq py3-setuptools binutils-dev binutils-avr binutils-gold && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py && pip3 install supervisor jupyterlab      && \
    sed -i "s/process.getuid && process.setuid/false/g" /usr/lib/node_modules/npm/node_modules/uid-number/uid-number.js                       && \
    curl -sLf https://spacevim.org/install.sh | sed "s,=~ \\\.SpaceVim\\$,== \$HOME/.SpaceVim,g" | sh -s -- --install vim                     && \
    adduser jupyter -u 1000 -D -S -s /bin/ash -G root && sed -i "s/Linux User,,,/jupyter/g" /etc/passwd                                       && \
    chmod 4755 /bin/busybox && echo -e "14ba9db3ef7a22c5\n14ba9db3ef7a22c5" | passwd root                                                     && \
	find /usr/lib/python* -name __pycache__ | xargs rm -rf && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.[acplnw]* /home/jupyter/*
    
# 配置环境变量
ENV PATH /usr/lib/jvm/default-jvm/bin:$PATH

RUN echo -e "\nexport JAVA_HOME=/usr/lib/jvm/default-jvm" | tee -a /etc/profile && \
    echo -e "export PATH=\$JAVA_HOME/bin:\$PATH"          | tee -a /etc/profile

# 切换用户
USER jupyter

# 创建目录
RUN mkdir -p /home/jupyter/notebook /home/jupyter/.supervisor/log /home/jupyter/.SpaceVim.d  && \
    mkdir -p /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension && \
    mkdir -p /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/terminal-extension         && \
    mkdir -p /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/fileeditor-extension       && \
    mkdir -p /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension

# 切换工作目录
WORKDIR /home/jupyter/notebook 

# 编写 SpaceVim 配置文件
RUN echo -e "\n[options]"                                      | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e 'colorscheme = "gruvbox"'                          | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e 'colorscheme_bg = "dark"'                          | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "enable_guicolors = false"                         | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e 'statusline_separator = "nil"'                     | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e 'statusline_inactive_separator = "bar"'            | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "buffer_index_type = 4"                            | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "windows_index_type = 3"                           | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "enable_tabline_filetype_icon = false"             | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "enable_statusline_mode = false"                   | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "statusline_unicode_symbols = false"               | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "vimcompatible = true"                             | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "name='autocomplete'"                              | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e 'auto-completion-return-key-behavior = "complete"' | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e 'auto-completion-tab-key-behavior = "cycle"'       | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "name = 'shell'"                                   | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "default_position = 'top'"                         | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "default_height = 30"                              | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "\n[[custom_plugins]]"                             | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "name='goofts/syntastic'"                          | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "name='lang#c'"                                    | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "\n[[layers]]"                                     | tee -a /home/jupyter/.SpaceVim.d/init.toml && \
    echo -e "name='lang#java'"                                 | tee -a /home/jupyter/.SpaceVim.d/init.toml

# 编写 Jupyter 配置文件
RUN echo -e "\nc.NotebookApp.allow_root = True"                             | tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.ip = '0.0.0.0'"                                  | tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.notebook_dir = u'/home/jupyter/notebook'"        | tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.open_browser = False"                            | tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.port = 30129"                                    | tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.certfile = u'/home/jupyter/.jupyter/jupyter.pem'"| tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.keyfile = u'/home/jupyter/.jupyter/jupyter.key'" | tee -a /home/jupyter/.jupyter/jupyter_notebook_config.py && \
    echo -e "c.NotebookApp.password = u'sha1:41e951df569e:f778d815bb1178a4f82dcfaa88a79b3c8e997451'"                          |  \
    tee  -a /home/jupyter/.jupyter/jupyter_notebook_config.py && echo -e '{\n\t"enabled": true\n}'                            |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension/plugin.jupyterlab-settings        && \
    echo -e '{"codeCellConfig":'                                                                                              |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings               && \
    echo -e '{"autoClosingBrackets":true,"fontFamily":"courier new","fontSize":16,"lineWrap":"on","lineNumbers":true},'       |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings               && \
    echo -e '"markdownCellConfig":'                                                                                           |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings               && \
    echo -e '{"autoClosingBrackets":false,"fontFamily":"courier new","fontSize":16,"lineNumbers":true},'                      |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings               && \
    echo -e '"rawCellConfig":'                                                                                                |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings               && \
    echo -e '{"autoClosingBrackets":false,"fontFamily":"courier new","fontSize":16,"lineNumbers":true}}'                      |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings               && \
    echo -e '{"editorConfig":{"fontFamily": "courier new","fontSize": 16,"lineNumbers":true}}'                                |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/fileeditor-extension/plugin.jupyterlab-settings              && \
    echo -e '{"fontFamily": "courier new","fontSize": 16,"shutdownOnClose": true}'                                            |  \
    tee  -a /home/jupyter/.jupyter/lab/user-settings/@jupyterlab/terminal-extension/plugin.jupyterlab-settings                && \
    echo -e "-----BEGIN PRIVATE KEY-----"                                         | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAN2uNX8hcPiesvbW"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "C+MuNvHSBneNo7+t7GN8VHKhUrqcCE2pjzqkkA33rVNgq9Fyv0weeFYZQCWVdBxn"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "ZtEDtYa+MiDoNLU0BKrl7agZPlkU095W/Y9Jf7HZ+y1DaV6dSg4hxJ2HpEF2AbVZ"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "NGzmiYX+ZUQbYrkjK1bud3euNbxhAgMBAAECgYBEWAo8OKYosFzChvlBQCVGZpcB"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "0tQyKz/e6Bzs/lmQGLzinK0Aym1zMPHp67rtJvBdWmOFP+Gr9KjIfQSQ2hDjd+k0"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "uLDwYuZW1aSo6RioHKyM0r+mH6wbZPPo/eDHMVeVMx45xhL/iaFfM9YWvW76fE3h"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "xDe+OL9nX0WZ/tSpwQJBAO/IzNXiMylNnRfvhdEQcFI3T6ksNpfR7rWbIWa0Qg6K"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "+e5u3QNh3kH+oTRHwDNc6HnEu3M33kcdT6vQ+RazAskCQQDsq/2ZZyJLtCFn08IK"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "7/mYOLkbgoB5ZSYe0mHeouDau2XQCKSZvPNbIDjcEUvxtHcpeTeuSxUI3HLYtzp1"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "hWDZAkEAsCmB85DfrXSL+U3LrjC5lG12ZP9KjHd7PIjgHShJb43C2N0yGo4IT8vW"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "eyZLmnCjivJyFM/yyaRLKBu7JGYXoQJBAJQ8RWLHzhtMf3/gijD/jX1iSc6JNp7S"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "U8YKT3J64gseRO6/+xiv2FzDGdn8m2yQc/JuEgoAzPP335cNbHgfSkECQAdAkvPo"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "VHMcdtIfWQBcggAc2NicfnMKgTTMq+Q4pEp3wTvz065caiS+y9GFproE9cVC7k6C"    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "68rCIb38fRn5ig0="                                                    | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "-----END PRIVATE KEY-----"                                           | tee -a /home/jupyter/.jupyter/jupyter.key && \
    echo -e "-----BEGIN CERTIFICATE-----"                                         | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "MIICiDCCAfGgAwIBAgIUFoNniAOC1jRr+d+5YR4eh+A+LqQwDQYJKoZIhvcNAQEL"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "BQAwVjELMAkGA1UEBhMCQ04xETAPBgNVBAgMCFpoZWppYW5nMREwDwYDVQQHDAhI"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "YW5nemhvdTEhMB8GA1UECgwYSW50ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMB4XDTE5"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "MDkwNTAxMjAwMFoXDTIwMDkwNDAxMjAwMFowVjELMAkGA1UEBhMCQ04xETAPBgNV"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "BAgMCFpoZWppYW5nMREwDwYDVQQHDAhIYW5nemhvdTEhMB8GA1UECgwYSW50ZXJu"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "ZXQgV2lkZ2l0cyBQdHkgTHRkMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDd"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "rjV/IXD4nrL21gvjLjbx0gZ3jaO/rexjfFRyoVK6nAhNqY86pJAN961TYKvRcr9M"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "HnhWGUAllXQcZ2bRA7WGvjIg6DS1NASq5e2oGT5ZFNPeVv2PSX+x2fstQ2lenUoO"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "IcSdh6RBdgG1WTRs5omF/mVEG2K5IytW7nd3rjW8YQIDAQABo1MwUTAdBgNVHQ4E"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "FgQU8QpKq1o97UpaUXUi5PMNSYZyAjowHwYDVR0jBBgwFoAU8QpKq1o97UpaUXUi"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "5PMNSYZyAjowDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOBgQB77Jbp"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "TPyz07i6ijpxqU4QpdT/k2ROLWxhIcSjteENSkvLjtMxUs49cswVuqZgs/eXxzrt"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "R48NdofNGZcQ/S4H0T+tANHWkH0wYL/9Ehy1z4TRIIDyZsHPO0CABNx+h0/MOmn4"    | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "e+LEUPzlt27r6lxDhDCa3/emaCED0d1l5GgYrg=="                            | tee -a /home/jupyter/.jupyter/jupyter.pem && \
    echo -e "-----END CERTIFICATE-----"                                           | tee -a /home/jupyter/.jupyter/jupyter.pem
    
# 编写开机启动文件
RUN echo -e "[supervisord]"                                               | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "nodaemon=true"                                               | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "pidfile=/home/jupyter/.supervisor/supervisord.pid"           | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "logfile=/home/jupyter/.supervisor/log/supervisord.log"       | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "\n[program:jupyterlab]"                                      | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "command=/usr/bin/jupyter lab"                                | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "stdout_logfile=/home/jupyter/.supervisor/log/jupyterlab.log" | tee -a /home/jupyter/.supervisor/supervisord.conf && \
    echo -e "stderr_logfile=/home/jupyter/.supervisor/log/jupyterlab.log" | tee -a /home/jupyter/.supervisor/supervisord.conf

# 开放管理端口
EXPOSE 30129

# 开机启动脚本
CMD supervisord -c /home/jupyter/.supervisor/supervisord.conf