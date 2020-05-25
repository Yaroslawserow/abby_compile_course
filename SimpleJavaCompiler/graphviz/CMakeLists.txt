set(HEADER_FILES graph.h)
set(SOURCE_FILES graph.cpp)
add_library(graphviz STATIC ${SOURCE_FILES} ${HEADER_FILES})
add_library(GraphvizWarmup::graphviz ALIAS graphviz)
