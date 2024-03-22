# vscode 如何debug python torchrun deepspeed



## 最优雅的方式


### 安装
1. 安装包 `pip install debugpy -U`
2. 安装vscode关于python的相关插件


### 写配置
一般情况下，大家都是使用deepspeed、torchrun运行代码。参数都特别多，然后都是使用`sh xxxx.sh`启动脚本。

#### 在python代码里面（最前面加上这句话）

```python
import debugpy
try:
    # 5678 is the default attach port in the VS Code debug configurations. Unless a host and port are specified, host defaults to 127.0.0.1
    debugpy.listen(("localhost", 9501))
    print("Waiting for debugger attach")
    debugpy.wait_for_client()
except Exception as e:
    pass

```

#### 在vscode的launch.json的configuration里面，加上这个配置

```json
{
            "name": "sh_file_debug",
            "type": "debugpy",
            "request": "attach",
            "connect": {
                "host": "localhost",
                "port": 9501
            }
        },

```

🚨 上面的端口号都写一样。别搞错了。


## 启动

1. 就正常启动，直接`sh xxx.sh`
2. 在你需要debug的python文件，打上debug断点。
2. 你看打印出来的东西，是不是出现`Waiting for debugger attach`.一般来说，都很快，就出现了。
3. 再在vscode的debug页面，选择`sh_file_debug`进行debug。
4. 就基本上完成了。确实是很方便。
5. **debug结束之后，别忘记把代码里面的 添加的代码，注销掉**
