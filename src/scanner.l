%option yylineno noyywrap

%{

#include <stdio.h>
#include <string.h>

%}

%%

.*\n { 
    printf("%d:%s", yylineno - 1, yytext);
}

%%

int main(void) {
    yylex();
    return 0;
}

