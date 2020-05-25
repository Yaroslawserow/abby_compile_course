cmake_minimum_required(VERSION 3.10)
project(Simplejavacompiler)
find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

BISON_TARGET(parser
             tokenizer/include/parser.yy
             ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.cc)
FLEX_TARGET (lexer
             tokenizer/include/lexer.l
             ${CMAKE_CURRENT_BINARY_DIR}/lexer.yy.cc)

ADD_FLEX_BISON_DEPENDENCY(lexer parser)

add_executable(
    Simplejavacompiler
    tokenizer/source/main.cpp
    tokenizer/source/file_scaner.cpp
    ${FLEX_lexer_OUTPUTS}
    ${BISON_parser_OUTPUTS}
)

target_link_libraries(
    Simplejavacompiler
    PUBLIC ast
)

target_link_libraries(
    Simplejavacompiler
    PUBLIC graphviz
)

target_include_directories(Simplejavacompiler PRIVATE . ${CMAKE_CURRENT_BINARY_DIR})

add_subdirectory(ast)
add_subdirectory(graphviz)


