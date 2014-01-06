# Try to find the libraries that are needed for creating Clang-based standalone
# tools using Clang's LibTooling.

# Once done, the following variables will be defined:
# - LibTooling_FOUND - system has LibTooling libraries
# - LibTooling_INCLUDE_DIRS - include directories
# - LibTooling_LIBRARIES - libraries to link

# First, find LLVM
find_program(LLVM_CONFIG_EXECUTABLE llvm-config DOC "llvm-config executable")
if(LLVM_CONFIG_EXECUTABLE-NOTFOUND)
  message(FATAL_ERROR "The `llvm-config` executable was not found. Please "
                      "install LLVM/clang and/or make it available to CMake.")
else()
  message(STATUS "llvm-config executable found: ${LLVM_CONFIG_EXECUTABLE}")
endif()

# Get auxiliary macros
include(LibFindMacros)
