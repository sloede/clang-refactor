cmake_minimum_required(VERSION 2.8)

# This is the main CMake configuration file for clang-refac

################################################################################
# Set project name, description & set language to C++ (disables C compiler)
project(clang-refactor CXX)
set(PROJECT_DESCRIPTION
    "A Clang/LibTooling-based tool for refactoring C++ code.")


################################################################################
# Configure paths - note that if you change any of them, you might need to
# change stuff in the utility scripts or the documentation as well
# Module path for custom CMake modules
set(CMAKE_DIR "cmake")
# Output path for binaries
set(BIN_DIR "bin")
# Directory with source files
set(SRC_DIR "src")
# Directory with header files
set(INCLUDE_DIR "src")
# Directory with documentation
set(DOC_DIR "doc")
# Directory with utilities
set(UTILS_DIR "utils")

################################################################################
# Configure targets
set(DOC_TARGET "doc")
set(DISTCLEAN_TARGET "distclean")
set(WHAT_TARGET "what")
set(BIN_TARGET "clang-refactor")

################################################################################
# Configure output names
set(BIN_NAME "clang-refactor")


################################################################################
# NO NEED TO CHANGE ANYTHING BEYOND THIS LINE
################################################################################


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/${CMAKE_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${LIB_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${LIB_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${BIN_DIR})
set(SRC_DIR_ABS ${CMAKE_SOURCE_DIR}/${SRC_DIR})
set(UTILS_DIR_ABS ${CMAKE_SOURCE_DIR}/${UTILS_DIR})

# Get LLVM include dir
include(FindLibTooling)
find_package(LibTooling)


#add_subdirectory(${SRC_DIR_ABS})
