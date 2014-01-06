# Try to find the libraries that are needed for creating Clang-based standalone
# tools using Clang's LibTooling.

# Once done, the following variables will be defined:
# - LIBTOOLING_FOUND - system has LibTooling libraries
# - LIBTOOLING_INCLUDE_DIRS - include directories
# - LIBTOOLING_LIBRARIES - libraries to link

# Set the libraries that need to be found:
set(LIBTOOLING_REQUIRED_LIBS
    "clangTooling" "clangFrontend" "clangSerialization" "clangDriver"
    "clangRewriteFrontend" "clangRewriteCore" "clangParse" "clangSema"
    "clangAnalysis" "clangAST" "clangASTMatchers" "clangEdit" "clangLex"
    "clangBasic")

# First, find LLVM
find_program(LLVM_CONFIG_EXECUTABLE "llvm-config" DOC "llvm-config executable")
mark_as_advanced(LLVM_CONFIG_EXECUTABLE)
if(LLVM_CONFIG_EXECUTABLE)
  message(STATUS "llvm-config executable found: ${LLVM_CONFIG_EXECUTABLE}")
else()
  message(FATAL_ERROR "The `llvm-config` executable was not found. Please "
                      "install LLVM/clang and/or make it available to CMake.")
endif()

# Get version
execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} "--version"
    OUTPUT_VARIABLE LIBTOOLING_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
message(STATUS "LibTooling version: ${LIBTOOLING_VERSION}")

# Get include dir
execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} "--includedir"
    OUTPUT_VARIABLE LIBTOOLING_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
message(STATUS "LibTooling include directory: ${LIBTOOLING_INCLUDE_DIR}")

# Get library dir
execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} "--libdir"
    OUTPUT_VARIABLE LIBTOOLING_LIBRARY_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
message(STATUS "LibTooling library directory: ${LIBTOOLING_LIBRARY_DIR}")

# Find all required libraries
foreach(_lib ${LIBTOOLING_REQUIRED_LIBS})
  set(varname "${_lib}_LIBRARY")
  find_library(${varname} NAME ${_lib} HINTS ${LIBTOOLING_LIBRARY_DIR})
  mark_as_advanced(${varname})
  if(${varname})
    message(STATUS "Found library `${_lib}`: ${${varname}}")
    set(LIBTOOLING_LIBRARY ${LIBTOOLING_LIBRARY} ${${varname}})
  else()
    message(FATAL_ERROR "The library `${_lib}` was not found.")
  endif()
endforeach()

# Set include directories and libraries
set(LIBTOOLING_INCLUDE_DIRS ${LIBTOOLING_INCLUDE_DIR})
set(LIBTOOLING_LIBRARIES ${LIBTOOLING_LIBRARY})

# Handle standard variables
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibTooling
    REQUIRED_VARS LIBTOOLING_LIBRARY LIBTOOLING_INCLUDE_DIR
    VERSION_VAR LIBTOOLING_VERSION)

# Save vars to cache that should be user-modifiable
set(LIBTOOLING_FOUND ${LIBTOOLING_FOUND}
    CACHE INTERNAL "Save if LibTooling was found.")
set(LIBTOOLING_LIBRARY ${LIBTOOLING_LIBRARY}
    CACHE FILEPATH "The LibTooling libraries.")
set(LIBTOOLING_INCLUDE_DIR ${LIBTOOLING_INCLUDE_DIR}
    CACHE FILEPATH "The LibTooling include directory.")
mark_as_advanced(LIBTOOLING_FOUND LIBTOOLING_LIBRARY LIBTOOLING_INCLUDE_DIR)
