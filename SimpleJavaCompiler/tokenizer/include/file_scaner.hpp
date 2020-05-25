#pragma once

#include <cctype>
#include <cstddef>
#include <fstream>
#include <istream>
#include <string>

#include "mc_scanner.hpp"
#include "parser.tab.hh"
#include "ast/handlers/expressions.hpp"
#include "ast/handlers/statements.hpp"
#include "ast/visitors/visitor_pretty_printer.hpp"
#include "ast/visitors/visitor_graphviz.hpp"

namespace MC {

typedef std::shared_ptr<ast::Expression> PExpression;
typedef std::shared_ptr<ast::ExpressionInt> PExpressionInt;
typedef std::shared_ptr<ast::ExpressionBinaryOp> PExpressionBinaryOp;

class MC_Driver{
public:
   MC_Driver() = default;

   virtual ~MC_Driver();

   void parse(const char * const input_filename, const char * const output_filename);
private:
   MC::MC_Parser  *parser  = nullptr;
   MC::MC_Scanner *scanner = nullptr;
};

}
