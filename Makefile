# Tested on macos 12 (m1) 
MACOS = -macosx_version_min 12.0.0
SYSTEM = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
DIR = ./output/

TARGET = HelloWorld
SRC_DIR := ./src
OBJ_DIR := ./obj
SRCS := $(wildcard $(SRC_DIR)/*.s)
OBJS := $(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS))

RM = rm -rf
RMALLO = find . -type f -name '*.o' -delete

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	ld $(MACOS) -o $(TARGET) $(OBJS) $(SYSTEM)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	as -o $(OBJS) $(SRCS)

clean:
	$(RM) $(TARGET) *.o
	cd $(OBJ_DIR)
	$(RMALLO)