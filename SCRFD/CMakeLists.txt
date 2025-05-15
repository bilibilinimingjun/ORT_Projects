cmake_minimum_required(VERSION 3.17)
project(scrfd)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 自定义库路径
# 自定义库路径
message(STATUS "Processor: ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "HOME_DIR $ENV{HOME}")
if (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
    set(LITE_AI_DIR ${CMAKE_SOURCE_DIR}/lite.ai.toolkit)
    set(ONNXRUNTIME_DIR $ENV{HOME}/library/onnxruntime-linux-x64-1.7.0)
    set(DDIM_SCHEDULER_DIR $ENV{HOME}/library/lite.ai.toolkit/lite/bin)
    set(OPENCV_LIB_DIR $ENV{HOME}/library/opencv-4.5.2/build/lib)
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
    set(LITE_AI_DIR ${CMAKE_SOURCE_DIR}/lite.ai.toolkit)
    set(ONNXRUNTIME_DIR $ENV{HOME}/library/onnxruntime-linux-aarch64-1.17.1)
    set(DDIM_SCHEDULER_DIR $ENV{HOME}/library/lite.ai.toolkit/lite/bin)
    set(OPENCV_LIB_DIR $ENV{HOME}/library/opencv-4.5.2/build/lib)
endif ()

message(STATUS "LITE_AI_DIR: ${LITE_AI_DIR}")
message(STATUS "ONNXRUNTIME_DIR: ${ONNXRUNTIME_DIR}")
message(STATUS "DDIM_SCHEDULER_DIR: ${DDIM_SCHEDULER_DIR}")
message(STATUS "OPENCV_LIB_DIR: ${OPENCV_LIB_DIR}")

# 查找 OpenCV 包
find_package(OpenCV REQUIRED)

# 包含头文件路径
include_directories(
    ${LITE_AI_DIR}/include
    ${ONNXRUNTIME_DIR}/include
    ${OpenCV_INCLUDE_DIRS}
)

# 链接库路径
link_directories(
    ${LITE_AI_DIR}/lib
    ${ONNXRUNTIME_DIR}/lib
    ${DDIM_SCHEDULER_DIR}
    ${OPENCV_LIB_DIR}
)

# 定义依赖库
set(TOOLKIT_LIBS lite.ai.toolkit onnxruntime ddim_scheduler_cpp)
set(OpenCV_LIBS ${OpenCV_LIBS})

# 添加可执行文件
add_executable(test_scrfd scrfd.cpp)

# 链接库
target_link_libraries(test_scrfd
    ${TOOLKIT_LIBS}
    ${OpenCV_LIBS}
)

# 添加 rpath，确保运行时也能找到（更安全）
set_target_properties(test_scrfd PROPERTIES
    INSTALL_RPATH "${DDIM_SCHEDULER_DIR};${OPENCV_LIB_DIR}"
)
