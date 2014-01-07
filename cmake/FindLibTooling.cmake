# Try to find the libraries that are needed for creating Clang-based standalone
# tools using Clang's LibTooling.

# Once done, the following variables will be defined:
# - LIBTOOLING_FOUND - system has LibTooling libraries
# - LIBTOOLING_INCLUDE_DIRS - include directories
# - LIBTOOLING_LIBRARIES - libraries to link
# - LIBTOOLING_CXXFLAGS - flags to use for the compiler
# - LIBTOOLING_SYSTEM_LIBRARIES - system libraries needed to link

# Set the libraries that need to be found:
set(LIBTOOLING_REQUIRED_LIBRARIES
    "clangTooling" "clangFrontend" "clangSerialization" "clangDriver"
    "clangRewriteFrontend" "clangRewriteCore" "clangParse" "clangSema"
    "clangAnalysis" "clangAST" "clangASTMatchers" "clangEdit" "clangLex"
    "clangBasic"
    "LLVMCore" "LLVMOption" "LLVMMC" "LLVMObject" "LLVMBitReader"
    "LLVMSupport" "LLVMAsmParser" "LLVMMCParser" "LLVMTransformUtils")

# First, find LLVM by way of the `llvm-config` executable
if(NOT LLVM_CONFIG_EXECUTABLE)
  find_program(LLVM_CONFIG_EXECUTABLE "llvm-config" DOC "llvm-config executable")
  mark_as_advanced(LLVM_CONFIG_EXECUTABLE)
  if(LLVM_CONFIG_EXECUTABLE)
    message(STATUS "llvm-config executable found: ${LLVM_CONFIG_EXECUTABLE}")
  else()
    message(FATAL_ERROR "The `llvm-config` executable was not found. Please "
                        "install LLVM/clang and/or make it available to CMake.")
  endif()
  set(LLVM_CONFIG_EXECUTABLE_PREV ${LLVM_CONFIG_EXECUTABLE} CACHE INTERNAL
      "Previous value (saved to detect changes)")
endif()

# Check if LLVM has changed
if((LLVM_CONFIG_EXECUTABLE STREQUAL LLVM_CONFIG_EXECUTABLE_PREV) AND
   FIND_LIBTOOLING_INITIALIZED)
  set(LLVM_HAS_CHANGED False)
else()
  set(LLVM_HAS_CHANGED True)
  set(LLVM_CONFIG_EXECUTABLE_PREV ${LLVM_CONFIG_EXECUTABLE} CACHE INTERNAL
      "Previous value (saved to detect changes)")
endif()

# If LLVM has changed, update all configuration variables
if(LLVM_HAS_CHANGED)
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

  # Get CXX flags
  execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} "--cxxflags"
      OUTPUT_VARIABLE LIBTOOLING_CXXFLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "LibTooling CXXFLAGS: ${LIBTOOLING_CXXFLAGS}")

  # Get system libraries
  execute_process(COMMAND ${LLVM_CONFIG_EXECUTABLE} "--system-libs"
      OUTPUT_VARIABLE LIBTOOLING_SYSTEM_LIBRARIES
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  string(STRIP "${LIBTOOLING_SYSTEM_LIBRARIES}" LIBTOOLING_SYSTEM_LIBRARIES)
  message(STATUS "LibTooling system libaries: ${LIBTOOLING_SYSTEM_LIBRARIES}")

  # Find all required libraries
  unset(LIBTOOLING_LIBRARY)
  foreach(_lib ${LIBTOOLING_REQUIRED_LIBRARIES})
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

  # Save vars to cache that should be user-modifiable
  set(LIBTOOLING_FOUND ${LIBTOOLING_FOUND}
      CACHE INTERNAL "Save if LibTooling was found.")
  set(LIBTOOLING_LIBRARY ${LIBTOOLING_LIBRARY}
      CACHE FILEPATH "The LibTooling libraries.")
  set(LIBTOOLING_INCLUDE_DIR ${LIBTOOLING_INCLUDE_DIR}
      CACHE FILEPATH "The LibTooling include directory.")
  set(LIBTOOLING_CXXFLAGS ${LIBTOOLING_CXXFLAGS}
      CACHE STRING "C++ compiler flags to use for the LibTooling library.")
  set(LIBTOOLING_SYSTEM_LIBRARIES ${LIBTOOLING_SYSTEM_LIBRARIES}
      CACHE STRING "System libraries to link for the LibTooling library.")
  mark_as_advanced(LIBTOOLING_FOUND LIBTOOLING_LIBRARY LIBTOOLING_INCLUDE_DIR)
endif()

# Set include directories and libraries
set(LIBTOOLING_INCLUDE_DIRS ${LIBTOOLING_INCLUDE_DIR})
set(LIBTOOLING_LIBRARIES ${LIBTOOLING_LIBRARY})

# Handle standard variables
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibTooling
    REQUIRED_VARS LIBTOOLING_LIBRARY LIBTOOLING_INCLUDE_DIR
    VERSION_VAR LIBTOOLING_VERSION)

# Set variable so we know that this it not the first run anymore
set(FIND_LIBTOOLING_INITIALIZED True CACHE INTERNAL
    "Variable set after first run.")
