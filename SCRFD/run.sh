#!/bin/bash
BASHRC="$HOME/.bashrc"

# 要添加的配置内容
CONFIGS=(
'export PATH=$PATH:/home/user/library/opencv-4.5.2/build/your-path-to-custom-dir/bin'
'export LD_LIBRARY_PATH=~/ORT-Projects/SCRFD/lite.ai.toolkit/lib:$LD_LIBRARY_PATH'
'export LIBRARY_PATH=~/ORT-Projects/SCRFD/lite.ai.toolkit/lib:$LIBRARY_PATH'
'export LD_LIBRARY_PATH=/home/user/library/opencv-4.5.2/build/lib:$LD_LIBRARY_PATH'
'export LD_LIBRARY_PATH=/home/user/library/lite.ai.toolkit/lite/bin:$LD_LIBRARY_PATH'
'export LD_LIBRARY_PATH=/home/user/library/onnxruntime-linux-aarch64-1.17.1/lib:$LD_LIBRARY_PATH'
)

echo "检查并更新 $BASHRC"

for line in "${CONFIGS[@]}"; do
    # 检查是否已存在该行
    if grep -Fxq "$line" "$BASHRC"; then
        echo "已存在: $line"
    else
        echo "$line" >> "$BASHRC"
        echo "已添加: $line"
    fi
done

source ~/.bashrc

# 如果存在 build 目录，则删除它
if [ -d "build" ]; then
    rm -rf build
fi

# 创建 build 目录并进入
mkdir build && cd build

# 构建项目
cmake -DCMAKE_BUILD_TYPE=Release .. && make -j1

# 运行程序
./test_scrfd
