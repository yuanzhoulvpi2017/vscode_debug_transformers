# vscode 如何debug python torchrun deepspeed

## ⚠️ 写在前面(一定要看)
1. debug程序的方式有很多种。每一种方式都各有缺点：有的方式虽然优雅，但是局限性很大；有的方式麻烦，但是局限性小。
    - 常规方式：
      - 优点：然后可以观察所有线程。一劳永逸。
      - 缺点：就是写参数很麻烦，但是你可以让chatgpt等大模型帮你写。
    - 最最最优雅的方式：
      - 优点：就是需要在代码里面，加入几行代码。方便快捷。
      - 缺点：有时候断点不生效，只能在一个线程里面启动。
2. 建议先使用【常规形式】、如果【常规形式】不够用，再使用【最最最优雅的方式】


### B站手把手视频
1. 常规方式：[https://www.bilibili.com/video/BV1Hh4y1i7Li](https://www.bilibili.com/video/BV1Hh4y1i7Li)
   - 对于torchrun这种形式：[https://www.bilibili.com/video/BV1b84y1R75V](https://www.bilibili.com/video/BV1b84y1R75V)
   - 对于deepspeed这种形式: [https://www.bilibili.com/video/BV1xC4y1P7LH](https://www.bilibili.com/video/BV1xC4y1P7LH)
2. 最最最优雅的方式：[https://www.bilibili.com/video/BV1wt421V718](https://www.bilibili.com/video/BV1wt421V718)




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
