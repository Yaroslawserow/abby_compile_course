%skeleton "lalr1.cc"
%require  "3.0"
%debug
%defines
%define api.namespace {MC}
%define api.parser.class {MC_Parser}

%code requires{
   #include <iostream>
   #include <cstdlib>
   #include <fstream>
   #include <string>

   #include "ast/handlers/expressions.hpp"
   #include "ast/handlers/statements.hpp"
   #include "ast/handlers/types.hpp"
   #include "ast/handlers/var_declaration.hpp"
   #include "ast/handlers/method_body.hpp"
   #include "ast/handlers/method_declaration.hpp"
   #include "ast/handlers/main_class.hpp"
   #include "ast/handlers/class.hpp"
   #include "ast/handlers/goal.hpp"

   namespace MC {
      class MC_Driver;
      class MC_Scanner;
   }

}

%parse-param { MC_Scanner  &scanner  }
%parse-param { MC_Driver  &driver  }
%parse-param { ast::PGoal* root }

%code{
   #include <memory>
   #include "tokenizer/include/file_scaner.hpp"

   MC::YYLTYPE LLCAST(MC::location x) { return MC::YYLTYPE({(x.begin.line), (x.begin.column), (x.end.line), (x.end.column)} ); }

#undef yylex
#define yylex scanner.yylex
}

%define api.value.type variant
%define parse.assert

%token<int> INTEGER_LITERAL
%token<std::string> LOGICAL_LITERAL
%token<std::string> OPERATION_LITERAL
%token<std::string> IDENTIFIER
%token<std::string> PUBLIC
%token EXTENDS
%token RETURN
%token INT
%token BOOLEAN
%token ASSIGN
%token DOT_COMMA
%token LBRACKET
%token RBRACKET
%token LSQUAREBRACKET
%token RSQUAREBRACKET
%token LBRACE
%token RBRACE
%token DOT
%token COMMA
%token LENGTH
%token UNARY_NEGATION
%token THIS
%token MAIN
%token CLASS
%token VOID
%token IF
%token ELSE
%token WHILE
%token PRINT
%token STRING
%token STATIC
%token END 0 "end of file"
%token NEW

%type<ast::PExpression> expr
%type<ast::PStatement> statement
%type<ast::PType> type
%type<ast::PVarDeclaration> var_declaration
%type<ast::PMethodBody> method_body
%type<ast::PMethodDeclaration> method_declaration
%type<ast::PMainClass> main_class
%type<ast::PClass> class
%type<ast::PGoal> goal

%type <std::vector<ast::PExpression>> expressions
%type <std::vector<ast::PStatement>> statements
%type <std::vector<ast::PVarDeclaration>> var_declarations
%type <std::vector<ast::PMethodDeclaration>> method_declarations
%type <std::vector<ast::PClass>> classes
%type <std::vector<std::pair<ast::PType, std::string>>> method_args
%locations

%left ASSIGN

%left OPERATION_LITERAL
%right UNARY_NEGATION
%right NEW

%right LBRACKET
%right LBRACE
%right LSQUAREBRACKET
%left IF
%left ELSE
%left COMMA
%left DOT
%left EXTENDS
%left RBRACKET
%left RBRACE
%left RSQUAREBRACKET

%start goal

%%

goal
      : main_class classes {$$ = std::make_shared<ast::Goal>($1, $2, LLCAST(@$)); *root = $$;}


main_class
      : CLASS IDENTIFIER LBRACE PUBLIC STATIC VOID MAIN LBRACKET STRING LSQUAREBRACKET RSQUAREBRACKET IDENTIFIER RBRACKET LBRACE statement RBRACE RBRACE
        {$$ = std::make_shared<ast::MainClass>($2, $4, $12, $15, LLCAST(@$));}


classes
      : classes class { $1.push_back($2); $$ = $1; }
      | {std::vector<ast::PClass> array; $$ = array;}


class
      : CLASS IDENTIFIER LBRACE var_declarations method_declarations RBRACE
          {$$ = std::make_shared<ast::Class>($2, $4, $5, LLCAST(@$));}
      | CLASS IDENTIFIER EXTENDS IDENTIFIER LBRACE var_declarations method_declarations RBRACE
          {$$ = std::make_shared<ast::Class>($2, $4, $6, $7, LLCAST(@$));}


method_args
      : type IDENTIFIER COMMA method_args
          {$4.push_back(std::make_pair($1, $2)); $$ = $4;}
      | type IDENTIFIER
          {std::vector<std::pair<ast::PType, std::string>> array; array.push_back(std::make_pair($1, $2)); $$ = array;}


method_declarations
      : method_declarations method_declaration
          { $1.push_back($2); $$ = $1; }
      | {std::vector<ast::PMethodDeclaration> array; $$ = array;}


method_declaration
      : PUBLIC type IDENTIFIER LBRACKET method_args RBRACKET method_body
          {$$ = std::make_shared<ast::MethodDeclaration>($1, $2, $3, $5, $7, LLCAST(@$));}
      | PUBLIC type IDENTIFIER LBRACKET RBRACKET method_body
          {$$ = std::make_shared<ast::MethodDeclaration>($1, $2, $3, std::vector<std::pair<ast::PType, std::string>>(), $6, LLCAST(@$));}


method_body
      : LBRACE var_declarations statements RETURN expr DOT_COMMA RBRACE
          {$$ = std::make_shared<ast::MethodBody>($2, $3, $5, LLCAST(@$));}

var_declaration
      : type IDENTIFIER DOT_COMMA {$$ = std::make_shared<ast::VarDeclaration>($1, $2, LLCAST(@$));}

var_declarations
      : var_declarations var_declaration { $1.push_back($2); $$ = $1; }
      | { std::vector<ast::PVarDeclaration> array; $$ = array; }

type
      : INT {$$ = std::make_shared<ast::TypeInt>(LLCAST(@$)); }
      | BOOLEAN {$$ = std::make_shared<ast::TypeBoolean>(LLCAST(@$)); }
      | INT LSQUAREBRACKET RSQUAREBRACKET {$$ = std::make_shared<ast::TypeArray>(LLCAST(@$)); }
      | IDENTIFIER {$$ = std::make_shared<ast::TypeClass>($1, LLCAST(@$)); }

statements
      : statement statements{ $2.push_back($1); $$ = $2; }
      | {std::vector<ast::PStatement> array; $$ = array;}

statement
      : IDENTIFIER ASSIGN expr DOT_COMMA
          {$$ = std::make_shared<ast::StatementAssign>($1, $3, LLCAST(@$));}

      | LBRACE statements RBRACE
          {$$ = std::make_shared<ast::Statements>($2, LLCAST(@$));}

      | IF LBRACKET expr RBRACKET statement ELSE statement
          {$$ = std::make_shared<ast::StatementIf>($3, $5, $7, LLCAST(@$));}

      | WHILE LBRACKET expr RBRACKET statement
          {$$ = std::make_shared<ast::StatementWhile>($3, $5, LLCAST(@$));}

      | PRINT LBRACKET expr RBRACKET DOT_COMMA
          {$$ = std::make_shared<ast::StatementPrint>($3, LLCAST(@$));}

      | IDENTIFIER LSQUAREBRACKET expr RSQUAREBRACKET ASSIGN expr DOT_COMMA
          {$$ = std::make_shared<ast::StatementArrayAssign>($1, $3, $6, LLCAST(@$));}


expressions
    : expressions COMMA expr { $1.push_back($3); $$ = $1;}
    | expr {std::vector<ast::PExpression> array; array.push_back($1), $$ = array;}

expr
    : INTEGER_LITERAL
        { $$ = std::make_shared<ast::ExpressionInt>    ($1, LLCAST(@$)); }
    | LOGICAL_LITERAL
        { $$ = std::make_shared<ast::ExpressionLogical>($1, LLCAST(@$)); }
    | NEW INT LSQUAREBRACKET expr RSQUAREBRACKET
        { $$ = std::make_shared<ast::ExpressionNewIntArray>($4, LLCAST(@$)); }
    | IDENTIFIER
        { $$ = std::make_shared<ast::ExpressionId>     ($1, LLCAST(@$)); }
    | NEW IDENTIFIER LBRACKET RBRACKET
        { $$ = std::make_shared<ast::ExpressionNewId>  ($2, LLCAST(@$)); }

    | expr DOT IDENTIFIER LBRACKET  RBRACKET
        { $$ = std::make_shared<ast::ExpressionCallFunction> ($1, $3, std::vector<ast::PExpression>(), LLCAST(@$)); }

    | expr DOT IDENTIFIER LBRACKET expressions RBRACKET
        { $$ = std::make_shared<ast::ExpressionCallFunction> ($1, $3, $5, LLCAST(@$)); }

    | LBRACKET expr RBRACKET { $$ = $2; }

    | expr OPERATION_LITERAL expr
        { $$ = std::make_shared<ast::ExpressionBinaryOp>($1, $3, $2, LLCAST(@$));}
    | expr LSQUAREBRACKET expr RSQUAREBRACKET
        { $$ = std::make_shared<ast::ExpressionSquareBracket>($1, $3, LLCAST(@$)); }
    | expr DOT LENGTH
        { $$ = std::make_shared<ast::ExpressionLen>($1, LLCAST(@$)); }

    | UNARY_NEGATION expr
        { $$ = std::make_shared<ast::ExpressionUnaryNegation>($2, LLCAST(@$)); }
    | THIS
        { $$ = std::make_shared<ast::ExpressionThis>(LLCAST(@$)); }

%%

void
MC::MC_Parser::error( const location_type &l, const std::string &err_message )
{
   std::cerr << "Error: " << err_message << " at " << l << "\n";
}
