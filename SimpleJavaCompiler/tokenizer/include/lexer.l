%{
#include <string>

#include "tokenizer/include/mc_scanner.hpp"
#undef  YY_DECL
#define YY_DECL int MC::MC_Scanner::yylex( MC::MC_Parser::semantic_type * const lval, MC::MC_Parser::location_type *loc )

using token = MC::MC_Parser::token;

#define YY_NO_UNISTD_H

#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

#define yyterminate() return token::END
%}

%option debug
%option nodefault
%option yyclass="MC::MC_Scanner"
%option noyywrap
%option c++

L_CLASS      "class"
L_PUBLIC    "public"
L_STATIC     "static"
L_VOID       "void"
L_MAIN       "main"
L_EXTENDS    "extends"
L_RETURN     "return"
L_IF         "if"
L_ELSE       "else"
L_WHILE      "while"
L_PRINT       "System.out.println"
L_LENGTH     "length"
L_NEW        "new"
L_THIS       "this"
L_TRUE       "true"
L_FALSE      "false"
L_STRING     "String"
L_BOOLEAN    "boolean"
L_INT        "int"
L_DIGIT      [0-9]
L_LETTER     [a-zA-Z_]
L_INTEGER_LITERAL   [1-9]{L_DIGIT}*|0
L_LOGIC_LITERAL     {L_TRUE}|{L_FALSE}
L_ID         {L_LETTER}({L_DIGIT}|{L_LETTER})*
L_COMMENT    (\/\/.*)|(\/\*((.|\n)*?)\*\/)
L_SPACE      [\n\r\t ]+
L_OPERATORS  "+"|"-"|"*"|"/"|"=="|"&&"|"<"|">"
L_ASSIGN     "="

L_DOT_COMMA ";"
L_DOT "."
L_COMMA ","
L_LBRACKET "("
L_RBRACKET ")"
L_LSQUAREBRACKET "["
L_RSQUAREBRACKET "]"
L_LBRACE "{"
L_RBRACE "}"
L_UNARY_NEGATION "!"

%%

%{
  yylval = lval;
%}


{L_EXTENDS} {
    std::cout << "L_EXTENDS" << "next" << std::endl;
    return token::EXTENDS;
}


{L_BOOLEAN} {
    std::cout << "L_BOOLEAN" << "next" << std::endl;
    return token::BOOLEAN;
}


{L_ELSE} {
    std::cout << "L_ELSE" << "next" << std::endl;
    return token::ELSE;
}

{L_PRINT} {
    std::cout << "L_PRINT" << "next" << std::endl;
    return token::PRINT;
}

{L_WHILE} {
    std::cout << "L_WHILE" << "next" << std::endl;
    return token::WHILE;
}

{L_IF} {
    std::cout << "L_IF" << "next" << std::endl;
    return token::IF;
}

{L_COMMA} {	
    std::cout << "L_COMMA" << "next" << std::endl;
    return token::COMMA;
}

{L_STATIC} {
    std::cout << "L_STATIC" << "next" << std::endl;
    return token::STATIC;
}

{L_CLASS} {
    std::cout << "L_CLASS" << "next" << std::endl;
    return token::CLASS;
}

{L_MAIN} {
    std::cout << "L_MAIN" << "next" << std::endl;
    return token::MAIN;
}

{L_STRING} {
    std::cout << "L_STRING" << "next" << std::endl;
    return token::STRING;
}

{L_VOID} {
    std::cout << "L_VOID" << "next" << std::endl;
    return token::VOID;
}

{L_PUBLIC} {
    std::cout << "L_PUBLIC" << "next" << std::endl;
    yylval->build<std::string>(yytext);
    return token::PUBLIC;
}

{L_RETURN} {
    std::cout << "L_RETURN" << "next" << std::endl;
    return token::RETURN;
}

{L_INT} {
    std::cout << "L_INT"  << "next" << std::endl;
    return token::INT;
}


{L_DOT_COMMA} {
    std::cout << "L_DOT_COMMA"  << "next" << std::endl;
    return token::DOT_COMMA;
}


{L_ASSIGN} {
    std::cout << "L_ASSIGN"  << "next" << std::endl;
    return token::ASSIGN;
}


{L_INTEGER_LITERAL} {
    std::cout << "L_INTEGER_LITERAL"  << "next" << std::endl;
    yylval->build<int>(atoi(yytext));
    return token::INTEGER_LITERAL;
}

{L_LOGIC_LITERAL} {
    std::cout << "L_LOGIC_LITERAL"  << "next" << std::endl;
    yylval->build<std::string>(std::string(yytext));
    return token::LOGICAL_LITERAL;
}

{L_LENGTH} {
    std::cout << "L_LENGTH"  << "next" << std::endl;
    return token::LENGTH;
}

{L_NEW} {
    std::cout << "L_NEW"  << "next" << std::endl;
    return token::NEW;
}

{L_THIS} {
    std::cout << "L_THIS"  << "next" << std::endl;
    return token::THIS;
}

{L_ID} {
    std::cout << "L_ID"  << "next" << std::endl;
    yylval->build<std::string>(yytext);
    return token::IDENTIFIER;
}

{L_COMMENT} {
    std::cout << "L_COMMENT"  << "next" << std::endl;
}

{L_SPACE} {
    std::cout << "L_SPACE"  << "next" << std::endl;
}

{L_OPERATORS} {
    std::cout << "L_OPERATORS"  << "next" << std::endl;
    yylval->build<std::string>(yytext);
    return token::OPERATION_LITERAL;
}

{L_LBRACKET} {
    std::cout << "L_LBRACKET"  << "next" << std::endl;
    return token::LBRACKET;
}

{L_RBRACKET} {
    std::cout << "L_RBRACKET"  << "next" << std::endl;
    return token::RBRACKET;
}

{L_LSQUAREBRACKET} {
    std::cout << "L_LSQUAREBRACKET"  << "next" << std::endl;
    return token::LSQUAREBRACKET;
}

{L_RSQUAREBRACKET} {
    std::cout << "L_RSQUAREBRACKET"  << "next" << std::endl;
    return token::RSQUAREBRACKET;
}

{L_LBRACE} {
    std::cout << "L_LBRACE"  << "next" << std::endl;
    return token::LBRACE;
}

{L_RBRACE} {
    std::cout << "L_RBRACE"  << "next" << std::endl;
    return token::RBRACE;
}

{L_DOT} {
    std::cout << "L_DOT"  << "next" << std::endl;
    return token::DOT;
}


{L_UNARY_NEGATION} {
    std::cout << "UNARY_NEGATION"  << "next" << std::endl;
    return token::UNARY_NEGATION;
}

<<EOF>>  {
    yyterminate();
    return 0;
}

.  { std::cout << std::endl << "UNKNOWN  " << yytext << std::endl; }
%%

