#include "../include/file_scaner.hpp"

MC::MC_Driver::~MC_Driver() {
    delete(scanner);
    scanner = nullptr;
    delete(parser);
    parser = nullptr;
}

void MC::MC_Driver::parse(const char * const input_filename, const char * const output_filename) {
    std::ifstream input_file(input_filename);
    std::ofstream output_file(output_filename);
    ast::PGoal root;

    delete(scanner);
    scanner = new MC::MC_Scanner(&input_file);

    delete(parser);
    parser = new MC::MC_Parser(*scanner, *this, &root);
    if (parser->parse()) {
        std::cerr << "Parsing failed!" << std::endl;
    }
    ast::VisitorPrettyPrinter visit_pretty_printer;
    root->accept(&visit_pretty_printer);

    ast::VisitorGraphviz visit_graphviz("my_graph");
    root->accept(&visit_graphviz);
    Graphs::UndirectedGraphSerializer::serialize(visit_graphviz.GetGraph(), output_file);
}
