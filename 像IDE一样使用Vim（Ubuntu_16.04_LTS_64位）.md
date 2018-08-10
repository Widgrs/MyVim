---
layout:	
title: 像IDE一样使用Vim（Ubuntu 16.04 LTS 64位）	
date: 2018-08-02 15:48
updated: 2018-08-09 17:54
comments: true
tags:
- 开发工具
- Vim
categories:
- 开发工具
- Vim	
permalink: 
---

[TOC]

# 1. 安装系统基础软件

本文针对的是在一个全新的Ubuntu16.04 64位操作系统上安装Vim，所以需要先安装一些最基础的系统软件。

<!-- more -->

```shell
sudo apt update
sudo apt install openssh-server
sudo apt install git
# 配置Git
git config --global user.name "Widgrs"
git config --global user.email "jichliu@163.com"
# 查看Git全局设置
git config --global -l
# 查看是否有SSH Keys
ls -al ~/.ssh
# 如果没有id_rsa文件，则生成一对密钥对
# 如果自己有常用的密钥对，则可以略过下一步，直接将私钥拷贝到~/.ssh目录下再更改文件权限即可
ssh-keygen -t rsa -b 4096 -C "Widgrs's Key"
# 更改id_rsa文件权限，如果提示权限太高则将权限改为600
chmod 644 id_rsa
# 将id_rsa.pub文件中的内容复制到GitHub SSH Keys设置中

# 测试是否能成功连接到GitHub
ssh -T git@github.com
# 如果成功，返回结果为：
# Hi Widgrs! You've successfully authenticated, but GitHub does not provide shell access.
# 如果提示Failed to add the host to the list of known hosts (/home/ubuntu/.ssh/known_hosts)
# 则在.ssh目录下新建一个known_hosts文件并将其权限更改为766

# 安装几个基础软件
sudo apt install lrzsz tree cmake checkinstall dos2unix curl
# 安装 pip（可选）
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
```

# 2. 源码编译安装Vim

参考 [Building Vim from source](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source) 使用源码编译安装Vim，前置条件：系统中已安装Git、CMake、checkinstall。

```shell
# 安装Vim相关依赖库的头文件，如果不需要python2、ruby、perl、gtk等也可以不安装
sudo apt install python-dev python3-dev ruby-dev liblua5.3-dev libperl-dev libncurses5-dev libx11-dev libgnome2-dev libgnomeui-dev libxt-dev libgtk2.0-dev
# 本人Ubuntu 16.04.3桌面版64位装上libgtk2.0-dev（或者libgtk-3-dev？？？鬼知道是哪一个）后会出现显卡故障、无法加载图形桌面的情况，所以这两个我都没装，反正编译也不会生成gvim，鬼知道为什么
# 如果不需要相关语言以及GVim也可以不安装对应的包
# sudo apt install python3-dev libncurses5-dev libx11-dev

# 下载最新版本的Vim源码
git clone git@github.com:vim/vim.git ~/Download/Vim
# 卸载系统自带的老版本Vim（如果有的话）
sudo apt remove vim vim-runtime gvim

# 编译Vim源代码并安装
cd ~/Download/Vim/
# Python3的头文件目录 /usr/lib/python3.5/config-3.5m-x86_64-linux-gnu 需要根据实际进行修改
# 不需要的功能也需要去掉对应的选项
./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu --enable-rubyinterp=yes --enable-perlinterp=yes --enable-luainterp=yes --enable-gui=gnome2 --enable-cscope --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
# 使用root权限安装，否则会提示“无法创建普通文件'/usr/local/bin/vim': 权限不够”
# 使用checkinstall打包安装方便卸载，卸载使用命令sudo dpkg -r packagename
# 也可以使用传统方式安装，命令为 sudo make install
sudo checkinstall

# 将Vim设置为默认编辑器
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
```

安装完成后在Vim中执行`:echo has('python3')` ，若输出 1 则表示构建出的 Vim 已支持 python3，反之输出 0 则表示不支持。

# 3. 安装LLVM + Clang

## 3.1 使用APT方式安装

这种应该是最简单的安装方式了，不过Ubuntu 16.04官方源里默认的Clang版本（3.8）已经很老了，自己添加软件源安装后的命令名称类似于clang-6.0，虽然可以自己改，但是多多少少会有点小问题也很烦。

```shell
# 查看仓库里LLVM/Clang的信息
sudo apt search llvm
sudo apt search clang
# 使用APT命令安装LLVM和Clang
sudo apt install llvm clang libc++-dev libc++abi-dev
```

## 3.2 使用预编译包安装

首先去 [LLVM Download Page](http://releases.llvm.org/download.html) 页面下载所需版本的预编译包，可以使用wget命令下载，也可以直接使用浏览器或迅雷下载下来之后再传到虚拟机中，然后在预编译包文件所在目录执行如下命令：

```shell
# 具体文件名称可以根据实际情况修改
cd ~/Download
wget http://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
xz -d clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
tar -xvf clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar
mkdir -p ~/Program/llvm
cp -r clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/* ~/Program/llvm
# cd ~/Program/llvm/bin 然后运行 ./clang --version 和 ./clang++ --version 命令检查是否成功安装
```

## 3.3 使用源代码编译安装

前置条件：系统中已安装GCC、CMake、xz + tar（用于解压缩文件）、Python（可选，用于自动化测试）。

从 [LLVM Download Page](http://releases.llvm.org/download.html) 页面下载需要的 LLVM、Clang、LLDB、libc++、libc++ ABI、complier-rt、clang-tools-extra 等源代码文件，按照 [Getting Started with the LLVM System](https://llvm.org/docs/GettingStarted.html) 页面介绍的目录结构将相应的文件夹放到正确的位置，然后创建一个build_tmp目录用于编译。

文件夹位置：

- LLVM：llvm
- Clang：llvm/tools/clang
- clang-tools-extra：llvm/tools/clang/tools/extra
- complier-rt：llvm/projects/compiler-rt
- libc++：llvm/projects/libcxx
- libc++ ABI：llvm/projects/libcxxabi
- LLDB：llvm/tools/clang/lldb
- LLD：llvm/tools/lld
- Test Suite：llvm/projects/test-suite

```shell
# llvm所有源代码位于 ~/Download/LLVM+Clang/llvm 目录下
cd ~/Download/LLVM+Clang
mkdir build_tmp
cd build_tmp
# 如果想clang/clang++自动使用libc++库，那么在编译clang时就需要指定DCLANG_DEFAULT_CXX_STDLIB参数值  为libc++，否则在链接的时候自动使用gcc/g++的libstdc++库
# 默认安装位置为 /usr/local，也可以使用 DCMAKE_INSTALL_PREFIX 参数指定安装位置
cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCLANG_DEFAULT_CXX_STDLIB=libc++ -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX=/home/ubuntu/Program/llvm ../llvm
# 使用四核编译加快编译速度
make -j4
make install
```

## 3.4 验证安装结果
使用预编译包安装或者源代码编译安装后需要设置环境变量和动态库信息，否则系统无法正常找到可执行文件所在的路径。在 ~/.bashrc 文件中添加如下内容，并执行 source ~/.bashrc 使其生效。

```shell
# 将可执行文件、头文件、动态库的路径加入系统环境变量，具体路径需要根据实际情况修改
LLVM_PATH=$HOME/Program/llvm/bin
export PATH=$PATH:$LLVM_PATH
LLVM_INCLUDE_PATH=$HOME/Program/llvm/include/c++/v1
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$LLVM_INCLUDE_PATH
LLVM_LIB_PATH=$HOME/Program/llvm/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LLVM_LIB_PATH
# 使修改后的 .bashrc 文件生效
source .bashrc
# 运行 clang --version 和 clang++ --version 命令检查是否成功安装
```

将clang和clang++设置为系统默认的编译器（可选）。

```shell
# 将clang和clang++设置为默认编辑器
sudo update-alternatives --install /usr/bin/cc cc /home/ubuntu/Program/llvm/bin/clang 1
sudo update-alternatives --set cc /home/ubuntu/Program/llvm/bin/clang
sudo update-alternatives --install /usr/bin/c++ c++ /home/ubuntu/Program/llvm/bin/clang++ 1
sudo update-alternatives --set c++ /home/ubuntu/Program/llvm/bin/clang++
```

创建一个验证文件test.cc，输入以下内容，然后执行编译命令 `clang++ -std=c++11 -stdlib=libc++ -Werror -Weverything -Wno-disabled-macro-expansion -Wno-float-equal -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-global-constructors -Wno-exit-time-destructors -Wno-missing-prototypes -Wno-padded -Wno-old-style-cast -lc++ -lc++abi test.cc` 并运行生成的可执行文件，看是否输出正确结果。

```c++
#include <iostream>
#include <string>

class MyClass
{
public:
  std::string s ="Hello, world\n"; // Non-static data member initializer
};

int main()
{
  std::cout << MyClass().s;
  return 0;
}
# 注意文件结尾要留一个空行，否则会报错

```

如果运行时提示 `error while loading shared libraries: libc++.so.1: cannot open shared object file: No such file or directory` ，是因为相关动态链接库被放在`/home/ubuntu/Program/llvm/lib`目录中，而系统默认在`/lib`和`/usr/lib`目录中查找动态链接库，所以需要将路径`/home/ubuntu/Program/llvm/lib`添加到`/etc/ld.so.conf`文件中，或者在`.bashrc`文件中设置`LD_LIBRARY_PATH`参数，两个方法选一个即可，前者对所有用户生效，后者只对当前用户生效。

打开`/etc/ld.so.conf`文件，发现里面只有一行内容，即`include /etc/ld.so.conf.d/*.conf`，所以可以在`/etc/ld.so.conf.d`目录下新建一个`usr-libs.conf`文件，然后将`/home/ubuntu/Program/llvm/lib`添加到`usr-libs.conf`文件中并执行`sudo ldconfig`或者重启系统即可。

对于Ubuntu 16.04系统，如果将链接库安装在/usr/local/lib目录下则不需要手动添加一个conf文件，因为系统默认自带的 libc.conf 文件中包含了 /usr/local/lib路径，所以只需要执行sudo ldconfig命令即可。

# 4. 安装Go开发环境

## 4.1 使用APT方式安装

Ubuntu 16.04官方源里默认的Go版本（1.6）也比较老了，安装命令为：

```shell
sudo apt install golang-go
```

## 4.2 使用预编译包安装

去 [Go官方网站](https://golang.org/dl/) 下载预编译的二进制包到本地，解压后复制到安装目录即可。

```shell
# 具体路径根据实际情况修改
cd ~/Download
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
tar -zxvf go1.10.3.linux-amd64.tar.gz
mkdir -p ~/Program/go
cp -r go/* ~/Program/go
```

## 4.3 验证安装结果

在 ~/.bashrc 文件中添加Go的路径信息，并执行source ~/.bashrc使其生效。使用APT方式安装时，可执行程序go默认安装在/usr/bin目录下，所以不需要再设置GOROOT，只需要设置GOPATH即可。

```shell
# $HOME/Code/Go目录即为Go的代码目录，可以根据实际情况修改。按照约定，其下有src、bin、pkg三个目录，src用于存放源代码，bin用于存放编译生成的可执行文件，pkg用于存放编译生成的中间文件
# 执行 go build project_name 即可编译项目
# 执行 go install project_name 即可编译项目并将生成的可执行文件拷贝到 bin 目录下
# 将 $GOPATH/bin 目录也添加进系统路径，这样就可以直接执行go生成的可执行文件
mkdir -p ~/Code/Go
export GOROOT=/usr/local/go
export GOPATH=$HOME/Code/Go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
```

创建一个验证文件test.go并输入以下内容，然后运行go run test.go查看是否输出正确结果。

```go
package main
import "fmt"

func main() {
    fmt.Println("Hello World!")
}
```

# 5. 安装插件

## 5.1 安装vim-plug插件

下载 [vim-plug](https://github.com/junegunn/vim-plug) 插件到 ~/.vim/autoload 目录：

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

安装 vim-plug 插件后在 .vimrc 文件中添加 call plug#begin() 和 call plug#end() 段并在其中添加插件信息，打开Vim运行`:PlugInstall`命令即可安装插件。插件会被默认下载到`~/.vim/plugged`目录，也可以自己制定目录。

## 5.2 安装Universal Ctags软件

由于ctags已经多年不维护了，所以使用其替代品[Universal Ctags](https://ctags.io/)，因为仓库里没有该软件，所以使用源码安装：

```shell
git clone git@github.com:universal-ctags/ctags.git ~/Download/ctags
cd ~/Download/ctags
# 如果提示 autoreconf: not found 需要安装 autoconf
# sudo apt install autoconf
# sudo apt install pkg-config
./autogen.sh
# 为了避免ctags名称冲突，安装时将其名称设为exctags
./configure --program-prefix=ex --prefix=/home/ubuntu/Program/exctags
make
make install
# 设置环境变量
# 使用 exctags --version 查看是否安装成功
```

Ctags软件是为了给vim-gutentags插件使用。[vim-gutentags](https://github.com/ludovicchabant/vim-gutentags) 是一个异步自动生成tags的插件，需要在后端调用ctags软件，其可以从文件当前路径向上递归查找是否有 `.git`, `.svn`, `.project` 等标志性文件（可以自定义）来确定当前文档所属的工程目录，并可以增量更新工程对应的tags文件。

## 5.3 从备份文件安装

将备份的 .vimrc 文件放到当前用户目录下，并根据具体配置信息修改其内容，然后打开Vim执行`:PlugInstall`命令安装插件。需要修改的地方包括：

* Gutentags 插件设置中 exctags 路径
* LeaderF 插件设置中 exctags 路径
* LeaderF 使用的 Python 版本
* YouCompleteMe 的 Python 补全版本
* YouCompleteMe 的 .ycm_extra_conf.py 文件路径

## 5.4 安装vim-go插件 

[vim-go](https://github.com/fatih/vim-go) 插件是一个用于支持Go语言开发的插件，首先在 .vimrc 文件中增加一行 `Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}` ，然后打开Vim执行`:PlugInstall`命令时会安装 vim-go 插件，然后自动执行 `:GoInstallBinaries` 命令安装相关的工具到`$GOPATH/bin`目录下。

注意：由于墙的原因，有些工具会下载失败，可以在 ~/.vim/plugged/vim-go/plugin/go.vim 文件的 s:packages 字段中找到没有正常下载的包名，自己去 [Golang中国](https://www.golangtc.com/download/package) 或者 https://github.com/golang/tools 网站下载，将下载的文件解压缩到`$GOPATH/src/golang.org/x/tools`目录下，然后执行如下命令安装：

```shell
# 为了避免一个一个包去下载，也可以把tools目录直接克隆到本地
# git clone https://github.com/golang/tools.git ~/Code/Go/src/golang.org/x/tools
# git clone git@github.com:golang/lint.git ~/Code/Go/src/golang.org/x/lint

go install github.com/kisielk/errcheck
go install github.com/zmb3/gogetdoc
go install golang.org/x/tools/cmd/goimports
go install github.com/golang/lint/golint
go install golang.org/x/tools/cmd/gorename
go install golang.org/x/tools/cmd/guru
go install github.com/josharian/impl
go install github.com/dominikh/go-tools/cmd/keyify
。。。等
```

## 5.5 安装YouCompleteMe插件

前置条件：已配置好Clang环境和Go环境（参考第三、四步）。

[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) 是一个功能强大的补全插件，首先编译YouCompleteMe共享库，执行如下操作后会在 ~/.vim/plugged/YouCompleteMe/third_party/ycmd 目录中生成 libclang.so.6、libclang.so.6.0、PYTHON_USED_DURING_BUILDING、ycm_core.so等文件。

```shell
# 安装YCM时要把 .bashrc 文件中的 LLVM_INCLUDE_PATH 先去掉，否则运行时会报链接错误
# 最好先断开连接重连一次或者重启一次机器再安装，否则有不定概率依然会导致链接错误，具体原因未明

# 单独手动安装 C/C++ 补全
# 如果不安装 boost 库文件则会报错
sudo apt install libboost-all-dev
mkdir -p ~/Download/ycm_build
cd ~/Download/ycm_build
# clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04 目录根据实际情况修改
cmake -G "Unix Makefiles" -DUSE_SYSTEM_BOOST=ON -DPATH_TO_LLVM_ROOT=~/Download/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04 . ~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core

# 自动安装 C/C++ 补全和 Go 补全(已配置好 Go 环境)
# 前置条件：已安装 build-essential cmake python3-dev
# sudo apt install build-essential cmake python3-dev
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --clang-completer --system-libclang --go-completer
```

YouCompleteMe会在当前路径以及上层路径寻找.ycm_extra_conf.py，也可以在.vimrc文件中指定.ycm_extra_conf.py的路径。将备份的.ycm_extra_conf.py文件放置于~/.vim/plugged/YouCompleteMe/third_party/config/目录下并修改.vimrc配置文件即可。

# 6. 参考资料

- [所需即所获：像 IDE 一样使用 vim](https://github.com/yangyangwithgnu/use_vim_as_ide)
- [Building Vim from source](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)


- [LLVM Download Page](http://releases.llvm.org/download.html)
- [Getting Started with the LLVM System](https://llvm.org/docs/GettingStarted.html)
- [CentOS7.3使用CMake编译安装最新的LLVM和Clang4.0.1](https://typecodes.com/linux/cmakellvmclang4.html)
- [The Go Programming Language](https://golang.google.cn/)
- [Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
- [一步一步带你安装史上最难安装的 vim 插件 —— YouCompleteMe](https://www.jianshu.com/p/d908ce81017a?nomobile=yes)
- [Ubuntu 16.04 64位安装YouCompleteMe](http://www.cnblogs.com/Harley-Quinn/p/6418070.html)
- [如何在 Linux 下利用 Vim 搭建 C/C++ 开发环境?](https://www.zhihu.com/question/47691414)
- [Vim 8 下 C/C++ 开发环境搭建](http://www.skywind.me/blog/archives/2084)


