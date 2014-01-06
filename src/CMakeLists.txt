set(src ClangRefac.cpp)

include_directories(${CMAKE_SOURCE_DIR}/${INCLUDE_DIR} ${INCLUDE_DIRS}
    ${LIBTOOLING_INCLUDE_DIRS})

add_executable(${BIN_TARGET} ${src})
set_target_properties(${BIN_TARGET} PROPERTIES OUTPUT_NAME ${BIN_NAME})
target_link_libraries(${BIN_TARGET} ${LIBRARIES})
