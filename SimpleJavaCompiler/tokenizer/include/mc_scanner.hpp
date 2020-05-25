#pragma once

#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"
#include "location.hh"

namespace MC {

class MC_Scanner : public yyFlexLexer {
public:
   explicit MC_Scanner(std::istream *in) : yyFlexLexer(in)
   {
   };
   virtual ~MC_Scanner() {
   };

   using FlexLexer::yylex;

   virtual int yylex(MC::MC_Parser::semantic_type * const lval,
              MC::MC_Parser::location_type *location );


private:
   MC::MC_Parser::semantic_type *yylval = nullptr;
};

}
