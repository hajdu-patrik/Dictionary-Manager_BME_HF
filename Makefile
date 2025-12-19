CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
LDFLAGS =
# Compilation Options (C Flags)
# -Wall: All warnings enabled
# -Wextra: Enable extra warnings (recommended)
# -std=c99: Use C99 standard
# -g: Add debugging information (useful for debuggers/debugmalloc)

SRC_DIR = src/main/c
INC_DIR = src/main/public
BUILD_DIR = build
DATA_DIR = data

# Target Executable Name
TARGET = $(BUILD_DIR)/dictionary_manager

# List of all .c source files in src/main/c
SOURCES = $(wildcard $(SRC_DIR)/*.c)

# List of object files generated during compilation
OBJECTS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))

.PHONY: all clean run copy_data

# ----------------- PRIMARY TARGETS -----------------
# 'all' creates the build dir, copies data, compiles, and links
all: $(BUILD_DIR) copy_data $(TARGET)

# Cleans (deletes) the object files and the executable
clean:
	@echo "Cleaning up..."
	rm -rf $(BUILD_DIR)

# ----------------- HELPER TARGETS -----------------
# Creates the build directory if it does not already exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Data Copy: Copies the 'data' folder to 'build/data'
# This ensures the program finds the .txt files when running from build/
copy_data:
	@echo "Copying data files..."
	@mkdir -p $(BUILD_DIR)
	@cp -r $(DATA_DIR) $(BUILD_DIR)/ 2>/dev/null || :

# Linking: Combines object files into the final executable
$(TARGET): $(OBJECTS)
	@echo "Linking executable..."
	$(CC) $^ $(LDFLAGS) -o $@

# Run target: Executes the program from the build directory
run: all
	@echo "Running $(TARGET)..."
	@cd $(BUILD_DIR) && ./$(notdir $(TARGET))

# Compilation: Compiles a single .c file into a .o object file
# -I$(INC_DIR): Tells the compiler where to look for header files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $@