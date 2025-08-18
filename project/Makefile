# 区分 C 和 C++ 编译器及编译选项
#CC       := gcc
#CXX      := g++
CFLAGS   += -Wall -O2
CXXFLAGS += -Wall -O2
LDFLAGS  +=

# 自动获取所有 .c 和 .cc 文件
SRCS_C  := $(wildcard *.c)
SRCS_CC := $(wildcard *.cc)
OBJS    := $(SRCS_C:.c=.o) $(SRCS_CC:.cc=.o)

TARGET := hello_world

.PHONY: all clean

all: $(TARGET)

# 链接阶段使用 C++ 编译器（兼容 C 对象文件）
$(TARGET): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

# 静态模式规则：针对特定目标列表的模式规则
#$(OBJS): %.o: %.c
#	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MMD -c $< -o $@

# 普通模式规则：通用的、隐式的模式规则，适用于所有匹配的目标
%.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

%.o: %.cc
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

# 包含自动生成的依赖文件
DEP_FILES := $(OBJS:.o=.d)
-include $(DEP_FILES)

clean:
	rm -rf $(DEP_FILES) $(OBJS) $(TARGET)
