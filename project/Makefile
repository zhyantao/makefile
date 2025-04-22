# 区分 C 和 C++ 编译器及编译选项
CC       := gcc
CXX      := g++
CFLAGS   := -Wall -O2
CXXFLAGS := -Wall -O2
LDFLAGS  :=

# 定义构建目录并确保其存在
BUILD_DIR := build
$(shell mkdir -p $(BUILD_DIR))

# 自动获取所有 .c 和 .cc 文件
SRCS_C  := $(wildcard *.c)
SRCS_CC := $(wildcard *.cc)
OBJS    := $(addprefix $(BUILD_DIR)/, $(SRCS_C:.c=.o) $(SRCS_CC:.cc=.o))

TARGET := hello

.PHONY: all clean

all: $(TARGET)

# 链接阶段使用 C++ 编译器（兼容 C 对象文件）
$(TARGET): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

# 静态模式规则：编译 C 和 C++ 文件到构建目录
$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

$(BUILD_DIR)/%.o: %.cc
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

# 包含自动生成的依赖文件（适配构建目录）
DEP_FILES := $(OBJS:.o=.d)
-include $(DEP_FILES)

clean:
	rm -rf $(BUILD_DIR) $(TARGET)
