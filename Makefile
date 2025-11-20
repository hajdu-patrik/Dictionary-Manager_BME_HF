# Compiler Setting
CC = gcc

# Compilation Options (C Flags)
# -Wall: All warnings enabled
# -Wextra: Enable extra warnings (recommended)
# -std=c99: Use C99 standard
# -g: Add debugging information (useful for debuggers/debugmalloc)
CFLAGS = -Wall -Wextra -std=c99 -g

# Linker Options (Library Flags)
LDFLAGS =

# Directory Names
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build

# Target Executable Name
TARGET = $(BUILD_DIR)/dictionary_manager

# List of all .c source files
SOURCES = $(wildcard $(SRC_DIR)/*.c)

# List of object files generated during compilation, placed in the build folder
OBJECTS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))

.PHONY: all clean

# ----------------- PRIMARY TARGETS -----------------
# 'all' is the primary target: Ensures the build directory exists, then starts linking
all: $(BUILD_DIR) $(TARGET)

# Cleans (deletes) the object files and the executable from the build folder
clean:
	rm -rf $(BUILD_DIR)

# ----------------- HELPER TARGETS -----------------
# Creates the build directory if it does not already exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Linking: Combines object files into the final executable
$(TARGET): $(OBJECTS)
	@echo "Linking executable..."
	$(CC) $^ $(LDFLAGS) -o $@

# Compilation: Compiles a single .c file into a .o object file
# -I$(INC_DIR): Tells the compiler where to look for header files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $@