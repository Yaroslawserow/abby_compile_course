cmake_minimum_required(VERSION 3.10)

file(GLOB_RECURSE SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*/*.cpp)
file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

add_library(ast STATIC ${SOURCES} ${HEADERS})

target_include_directories(ast PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(CMakeExample::ast ALIAS ast)
