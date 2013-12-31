cmake_minimum_required(2.8)

project(clang-refac CXX)
set(PROJECT_DESCRIPTION
    "A Clang/LibTooling-based tool for refactoring C++ code.")

set(CMAKE_DIR "cmake")
set(BIN_DIR "bin")
set(SRC_DIR "src")
set(INCLUDE_DIR "src")
set(DOC_DIR "doc")
set(UTILS_DIR "utils")

set(DOC_TARGET "doc")
set(DISTCLEAN_TARGET "distclean")
set(WHAT_TARGET "what")
set(BIN_TARGET "clang-refac")
set(BIN_NAME "clang-refac")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${LIB_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${LIB_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${BIN_DIR})
set(SRC_DIR_ABS ${CMAKE_SOURCE_DIR}/${SRC_DIR})
set(UTILS_DIR_ABS ${CMAKE_SOURCE_DIR}/${UTILS_DIR})

add_subdirectory(${SRC_DIR_ABS})
