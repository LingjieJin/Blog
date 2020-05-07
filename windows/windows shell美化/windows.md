# WIN10 美化

---

## PowerShell美化

### 使能PowerShell权限

在windows中打开开发者选项 使能powershell脚本打开权限

```bash
# 使用以下命令查看
get-executionpolicy

# Unrestricted   //  未签名的脚本可以运行。（这存在运行恶意脚本的风险。）
# RemoteSigned //  要求从 Internet 下载的脚本和配置文件（包括电子邮件和即时消息程序）具有受信任的发布者的数字签名
# AllSigned // 要求所有脚本和配置文件都由受信任的发布者签名，包括在本地计算机上编写的脚本
# Restricted // 允许单独的命令，但不会运行脚本。
# PROCESS // 执行策略仅影响当前会话（当前 Windows PowerShell 进程）。
# CURRENTUSER  // 执行策略仅影响当前用户。它存储在 HKEY_CURRENT_USER 注册表子项中。
# Bypass // 不阻止任何内容，并且没有任何警告或提示。
# Undefined // 当前作用域中未设置执行策略。
# LOCALMACHINE // 执行策略会影响当前计算机上的所有用户。它存储在 HKEY_LOCAL_MACHINE 注册表子项中。

# 执行权限设置
Set-ExecutionPolicy
# or
Set-ExecutionPolicy -Scope CurrentUser
```

### 添加Scoop包管理

1. 环境要求

1.1 Windows 版本不低于 Windows 7

1.2 Windows 中的 PowerShell 版本不低于 PowerShell 3

1.3 你能 正常、快速 的访问 GitHub 并下载上面的资源

1.4 你的 Windows 用户名为英文（Windows 用户环境变量中路径值不支持中文字符）

2. 安装 scoop

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

3. 安装字体

```
# 搜索 nerd fonts，这里选择是的FantasqueSansMono这个字体
scoop search FantasqueSansMono-NF

# 添加 nerd fonts 源
scoop bucket add 'nerd-fonts'

# 安装 nerd fonts
scoop install FantasqueSansMono-NF
```

4. 安装颜色工具

```
# 安装微软官方颜色工具
scoop install colortool

# 查看已安装主题
colortool -s

# 设置主题
colortool OneHalfDark

```

### chocolaty包管理

1. 安装 chocolaty

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

2. 使用chocolaty安装ConEmu终端

choco install ConEmu

2.1 ConEmu设置请参考

[ConEmu设置](https://blog.csdn.net/Akilarex/article/details/89283304?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1)

### 下载Powerline字体

```
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.ps1
cd ..
del .\fonts\ -recurse

```

### 下载shell插件

```
# 安装posh-git和oh-my-posh等插件
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module Get-ChildItemColor -Scope CurrentUser

# 启用默认设置
Set-Prompt
# 选中主题
Set-Theme Paradox

# 安装完成后，需要修改主题配置的脚本文件
# 使用记事本打开PS配置文件（如无则创建该文件）
if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
notepad $PROFILE

在打开的.ps1配置文件中加入以下内容：
Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor
Set-Theme Paradox

其他的主题还有：
https://github.com/JanDeDobbeleer/oh-my-posh

# 修改Powershell终端显示

1. 字体修改
修改字体大小以及选择字体，之前安装的字体，比如Deja Vu Sans 

2. 显示效果修改
在color选项里面修改前景色和背景色，以及透明度

```
## 参考文章

[参考文章](https://zhuanlan.zhihu.com/p/51901035)

[参考文章](https://www.jianshu.com/p/4b2b7074d9e2)

---

## Windows Terminal设置

### 下载安装windows terminal

打开store 下载windows terminal，OK。

## Windows Terminal 配置文件JSON

[参考文章](https://zhuanlan.zhihu.com/p/104720872)

[参考文章](https://zhuanlan.zhihu.com/p/51901035)

### 设置windows terminal桌面右键启动

1. 注册表修改方式

1.1 win+r 输入regedit进入注册表修改

1.2 找到\HKEY_CLASSES_ROOT\Directory\Background\shell

1.3 在该目录下新建项，例如命名为Terminal

1.3.1 给Terminal项的默认值赋值为你想要的名字，比如：Windows Terminal Here

1.3.2 在Terminal下新建一个名为Ico的字符串值，同时赋值为你存放图标地址的位置

1.4 在Terminal目录下新建command项

1.4.1 给command项的默认值修改为你的windows terminal所在目录，一般在C:\Users\用户名\AppData\Local\Microsoft\WindowsApps\wt.exe下

1.5 打开windows terminal发现并没有在当前目录打开，配置windows terminal的profiles.json,设置选项"startingDirectory": "./"或者"startingDirectory": null都可以达到当前目录打开的效果

2. 脚本自动修改

2.1 准备工作

2.1.1 将Ico文件保存到 C:\Users\用户名\Pictures\terminal.ico
测试本机用户目录地址（最好使用cmd shell测试，power shell无法输出）：

```
echo %USERPROFILE%

echo %LOCALAPPDATA%
```

2.1.2 

复制以下文本，保存为.reg格式，运行导入。

其中用户名字段请改为自己的电脑用户名

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\wt]
@="Windows Terminal here (&T)"
"Icon"="%USERPROFILE%\\Pictures\\terminal.ico"

[HKEY_CLASSES_ROOT\Directory\Background\shell\wt\command]
@="C:\\Users\\用户名\\AppData\\Local\\Microsoft\\WindowsApps\\wt.exe"

```

---

## VS Code修改默认终端

### 修改vscode默认终端为指定终端

1. F1后输入select shell,选择vscode默认打开的shell
2. 文件->首选项->设置，搜索shell，找到Terminal>Integrated>Shell，打开json设置
2.1 shell路径
> powershell: "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
> cmd: "C:\\Windows\\System32\\cmd.exe"
> bash: "D:\\soft\\git\\bin\\bash.exe"



