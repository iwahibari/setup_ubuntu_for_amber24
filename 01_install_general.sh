#!/bin/bash
# PC setup script for Ubuntu 24.04.1

# 前処理
sudo apt update
sudo apt -y upgrade
sudo apt -y autoremove

sudo apt -y install gcc
sudo -y apt install gcc-12 gcc-12-base libgcc-12-dev
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 20
0 | sudo update-alternatives --config gcc

sudo apt -y install make
sudo apt -y install cmake
sudo apt -y install vim 
sudo apt -y install openssh-server
sudo apt -y install csh

# 既存グラフィックドライバの無効化
sudo sh -c "cat > /etc/modprobe.d/blacklist-nouveau.conf" << EOF
blacklist nouveau
options nouveau modeset = 0
EOF

wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/570.144/NVIDIA-Linux-x86_64-570.144.run

# CHECK
correct_gcc_version=12

echo -e "\e[34m- checking make\e[m"
if echo -e `apt list --installed 2>/dev/null | grep make` | grep -qe "installed" -qe "インストール済み"; then
	echo -e "\e[32m[OK] make is installed\e[m"
else
	echo -e "\e[31m[NG] make is not found in \"apt list\"\e[m"
fi

echo -e "\e[34m- checking cmake\e[m"
if echo -e `apt list --installed 2>/dev/null | grep cmake` | grep -qe "installed" -qe "インストール済み"; then
        echo -e "\e[32m[OK] cmake is installed\e[m"
else
        echo -e "\e[31m[NG] cmake is not found in \"apt list\"\e[m"
fi

echo -e "\e[34m- checking vim \e[m"
if echo -e `apt list --installed 2>/dev/null | grep vim` | grep -qe "installed" -qe "インストール済み"; then
        echo -e "\e[32m[OK] vim is installed\e[m"
else
        echo -e "\e[31m[NG] vim is not found in \"apt list\"\e[m"
fi

echo -e "\e[34m- checking openssh-server\e[m"
if echo -e `apt list --installed 2>/dev/null | grep openssh-server` | grep -qe "installed" -qe "インストール済み"; then
        echo -e "\e[32m[OK] openssh-server is installed\e[m"
else
        echo -e "\e[31m[NG] openssh-server is not found in \"apt list\"\e[m"
fi

echo -e "\e[34m- gccのバージョンが${correct_gcc_version}か確認\e[m"
gcc_v=`gcc --version | grep gcc`
cut_int_f=${#gcc_v}
cut_int_i=$(( cut_int_f - 5 ))
cut_int_ii=$(( cut_int_i + 1 ))
gcc_v_2=`echo -e ${gcc_v} | cut -c ${cut_int_i}-${cut_int_ii}` 

if [ ${gcc_v_2} = ${correct_gcc_version} ]; then
	echo -e "\e[32m[OK] gcc のバージョンは${correct_gcc_version}です\e[m"
else
	echo -e "\e[31m[NG] gccのバージョンが${correct_gcc_version}ではありません: ${gcc_v}\e[m"
fi

echo -e "\e[34m- ipアドレスを確認\e[m"
ip_address=`ip a | grep 192.168 | cut -c 10-22`
echo -e "ipアドレス: ${ip_address}"

echo -e "\e[34m- 既存ドライバの設定を確認\e[m"
if [ -e /etc/modprobe.d/blacklist-nouveau.conf ]; then
	echo -e "\e[32m[OK] nouveauの無効化を確認\e[m"
else
	echo -e "\e[31m[NG] nouveauが無効化されていません\e[m"
fi
