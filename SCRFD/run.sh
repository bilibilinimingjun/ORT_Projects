#!/bin/bash

BASHRC="$HOME/.bashrc"
echo "检查并更新 $BASHRC"

# 实际路径，支持 ~ 替换为绝对路径
CONFIGS=(
'export PATH=$PATH:$HOME/library/opencv-4.5.2/build/bin'
'export LD_LIBRARY_PATH=$HOME/ORT_Projects/SCRFD/lite.ai.toolkit/lib:$LD_LIBRARY_PATH'
'export LIBRARY_PATH=$HOME/ORT_Projects/SCRFD/lite.ai.toolkit/lib:$LIBRARY_PATH'
'export LD_LIBRARY_PATH=$HOME/library/opencv-4.5.2/build/lib:$LD_LIBRARY_PATH'
'export LD_LIBRARY_PATH=$HOME/library/lite.ai.toolkit/lite/bin:$LD_LIBRARY_PATH'
'export LD_LIBRARY_PATH=$HOME/library/onnxruntime-linux-aarch64-1.17.1/lib:$LD_LIBRARY_PATH'
)

# 确保每个变量只添加一次
for line in "${CONFIGS[@]}"; do
    if ! grep -Fxq "$line" "$BASHRC"; then
        echo "$line" >> "$BASHRC"
        echo "已添加: $line"
    else
        echo "已存在: $line"
    fi
done

# 更新当前 shell 环境
source "$BASHRC"

# 删除旧 build 文件夹
rm -rf build

# 构建项目
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release .. && make -j$(nproc)

# 运行程序
./test_scrfd
