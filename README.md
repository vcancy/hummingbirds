# Hummingbirds[蜂鸟]

### 该容器专为为编程初学者提供提供不同脚本语言的交互式编程环境。<br />容器默认端口为31219，初始密码为goofts@zl.com。<br />用户第一次登陆后建议修改密码以防容器被恶意用户使用。

---
## 修改密码
1. 浏览器打开hummingbirds，新建一个python3文件，输入：
```python3
from notebook.auth import passwd
passwd()
```

2. shift+enter执行命令后，按提示输入密码。

3. 获得密码的密文：
```python3
sha1:f4735e614fa8:4ccb906920776388f0610816efd7c70ac46879d5
```

4. 新建一个bash文件，使用sed命令替换配置文件上的密码密码：
```python3
# sed -i "s/原密码/修改后密码/g" filename
sed -i "s/sha1:41e951df569e:f778d815bb1178a4f82dcfaa88a79b3c8e997451/sha1:f4735e614fa8:4ccb906920776388f0610816efd7c70ac46879d5/g" \
/root/.jupyter/jupyter_notebook_config.py
```

5. 重启docker：
```python3
docker restart CONTAINER_ID
```

---
## 更新日志
2019-07-29<br />
为 master 容器的vim增加java和c++的插件