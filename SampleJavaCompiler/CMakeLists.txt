cmake_minimum_required(VERSION 3.0)

SET (CMAKE_CXX_COMPILER  "/usr/bin/clang++")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wno-deprecated-register")

project(javacompiler CXX)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

BISON_TARGET(parser
             source/parser.yy
             ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.cc)
FLEX_TARGET (mc_lexer
             source/lexer.l
             ${CMAKE_CURRENT_BINARY_DIR}/lexer.yy.cc)

add_subdirectory(source/ast)
add_subdirectory(source/smart_graphviz)

ADD_FLEX_BISON_DEPENDENCY(lexer parser)

add_executable(javacompiler
    source/main.cpp
    source/driver.cpp

    ${FLEX_mc_lexer_OUTPUTS}
    ${BISON_mc_parser_OUTPUTS}
)

target_link_libraries(javacompiler
    PUBLIC ast
)

target_link_libraries(javacompiler
    PUBLIC smart_graphviz
)

target_include_directories(javacompiler
    PRIVATE . ${CMAKE_CURRENT_BINARY_DIR})

set_property(TARGET javacompiler
    PROPERTY CXX_STANDARD 11)

message("Current binary dir: " ${CMAKE_CURRENT_BINARY_DIR})
