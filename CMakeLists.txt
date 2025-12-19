cmake_minimum_required(VERSION 3.10)

# Project name and language (C)
project(DictionaryManagerC LANGUAGES C)

# Set C standard (C99)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Location of header files (src/main/public)
include_directories(src/main/public)

# Search for source files RECURSIVELY within the src folder
# This will find .c files in both the src/main/c and src/main/public folders
file(GLOB_RECURSE SOURCES "src/*.c")

# Check: If no files are found, an error message is displayed
if(NOT SOURCES)
    message(FATAL_ERROR "ERROR: No .c files found in the 'src' folder!")
endif()

# Create executable
add_executable(dictionary_manager ${SOURCES})

# Compiler switches (Windows vs Linux/Mac)
if(MSVC)
    # /TC forces C compilation in Visual Studio, /W3 warnings
    target_compile_options(dictionary_manager PRIVATE /W3 /D_CRT_SECURE_NO_WARNINGS /TC)
else()
    # GCC/Clang switches
    target_compile_options(dictionary_manager PRIVATE -Wall -Wextra -Wpedantic -g)
endif ()

# Define Memtrace (debugmalloc) if necessary
target_compile_definitions(dictionary_manager PRIVATE MEMTRACE)

# --- DATA COPY ---
# After build, copy the 'data' folder next to the exe so that the program can find the dictionaries
add_custom_command(TARGET dictionary_manager POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/data
    $<TARGET_FILE_DIR:dictionary_manager>/data
    COMMENT "Copying data folder to executable directory...")
