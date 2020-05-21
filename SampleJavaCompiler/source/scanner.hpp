#pragma once

#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"
#include "location.hh"

namespace analizer {

class Scanner : public yyFlexLexer {
public:
   explicit Scanner(std::istream *in) : yyFlexLexer(in)
   {
   };
   virtual ~Scanner() {
   };s

   using FlexLexer::yylex;

   virtual int yylex( MC::Parser::semantic_type * const lval,
              analizer::Parser::location_type *location );


private:
   analizer::Parser::semantic_type *yylval = nullptr;
};

}
