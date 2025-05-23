#! /bin/bash

echo -e "\e[31m本スクリプトは一回しか実行しないでください\e[m"

bashrcfile=~/.bashrc

cat << EOF >> ${bashrcfile}
export PATH="/usr/local/cuda/bin:\$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:\$LD_LIBRARY_PATH"
EOF

source ${bashrcfile}
echo "path added"

# check

echo -e "\e[34m- checking nvidia-driver\e[m"
if echo -e `nvidia-smi | grep NVIDIA-SMI` | grep -q "Driver Version"; then
	echo -e "\e[32m[OK] nvidia-driver is installed\e[m"
else
	echo -e "\e[31m[NG] nvidia-driver is not found in \"apt list\"\e[m"
fi

echo -e "\e[34m- checking cmake\e[m"
if echo -e `nvcc --version` | grep -q "Copyright (c)"; then
        echo -e "\e[32m[OK] nvcc is installed\e[m"
else
        echo -e "\e[31m[NG] nvcc is not found in \"apt list\"\e[m"
fi
