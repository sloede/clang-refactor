set(src ClangRefactor.cpp)

# Set include directories
include_directories(${CMAKE_SOURCE_DIR}/${INCLUDE_DIR} ${INCLUDE_DIRS}
    ${LIBTOOLING_INCLUDE_DIRS})

# Set compiler flags
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_COMPILER_FLAGS}
    ${LIBTOOLING_CXXFLAGS})

# Create executable
add_executable(${BIN_TARGET} ${src})

# Set output name for executable
set_target_properties(${BIN_TARGET} PROPERTIES OUTPUT_NAME ${BIN_NAME})

# Link libraries to executable
target_link_libraries(${BIN_TARGET} ${LIBTOOLING_LIBRARIES}
                      ${LIBTOOLING_SYSTEM_LIBRARIES})
