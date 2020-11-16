# Masm

## 环境的搭建

### 安装dosbox

```shell
sudo apt-get install dosbox
```

#### 下载汇编必须的程序

* masm.exe
* link.exe
* debug.exe

以上的程序的下载
<https://pan.baidu.com/s/1OpD1UX-nwGOK5rL7v_-z1Q> 提取码: dzwy

下载后创建一个文件夹 命名Masm（自定义）将下载好的程序放入该文件夹中
终端运行dosbox

 ```termianl
 dosbox
 ```

进入dos环境，在dos环境中挂载c盘，并进入

```shell
mount c  /xx/Masm
c:

```

### 汇编程序的编写执行

在Masm中打开文本编辑器,输入以下代码，保存为hello.asm

```shell
 DATA    SEGMENT
      STRING  DB   'Hello World!', '$'
  DATA    ENDS

  STACK1  SEGMENT PARA    STACK
      DW  20H DUP  (0)
  STACK1  ENDS
  CODE   SEGMENT
  ASSUME  CS:CODE, DS:DATA, SS:STACK1
  BEGIN:  MOV     AX, DATA
      MOV DS, AX
      LEA     DX, STRING
      MOV     AH, 9
      INT     21H
      MOV     AH, 4CH
      INT 21H
  CODE   ENDS
      END BEGIN
```

在dos环境中

```terminal
MASM.EXE HELLO.ASM  #不区分大小写
#按三次回车键
LINK.EXE HEELO.OBJ
#三次回车
HELLO.EXE
#输出Hello World！  
EXIT #退出dos
```

### Dosbox的配置

Dosbox的配置文件位于当前用户目录下的.dosbox中

```shell
$ vim .dosbox/dosbox-0.74-2.conf
#[autoexec]下添加,在运行dosbox时自动挂载
mount c: /home/username/Masm
c:
#或者在执行dosbox时
$ dosbox -c "mount c: /home/username/Masm"
```

### VSCODE为dosbox配置task任务

在.vsocode下创建tasks.json
输入

```json
{

    "version": "2.0.0",
    "tasks": [
        {
            "label": "dosbox",
            "type": "shell",
            "command": "dosbox",
            "args": [
                "-c",
                "mount c: ${workspaceFolder}",
                "-c",
                "c:",
                "-c",
                "MASM ${fileBasenameNoExtension}.asm",
                "-c",
                "LINK ${fileBasenameNoExtension}.obj",
                "-c",
                "DEBUG ${fileBasenameNoExtension}.exe",
                "-c",
                "exit"
            ],
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

shift+ctrl+B
