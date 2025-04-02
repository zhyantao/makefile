CXX := g++
CXXFLAGS := -c -Wall
LDFLAGS :=

TARGET := hello
SRCS := $(wildcard *.cc)
OBJS := $(patsubst %.cc, %.o, $(SRCS))

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

$(OBJS): %.o: %.cc
	$(CXX) -o $@ -c $< $(CXXFLAGS)

clean:
	rm -f *.o $(TARGET)
