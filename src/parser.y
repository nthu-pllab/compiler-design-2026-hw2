%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;
int yylex();

%}

%union {
  int intVal;
  double dblVal;
  char *strVal;
  char chVal;
}

%token <strVal> INT_TYPE DOUBLE_TYPE FLOAT_TYPE
%token <chVal> ';'
%token <strVal> IDENT

%type <strVal> program declaration

%%

program:
declaration
| program declaration
;

declaration:
FLOAT_TYPE IDENT ';' {printf("<scalar_decl>%s%s;</scalar_decl>\n",$1,$2);}
;

%%

int main(void) {
  yyparse();
  return 0;
}

void yyerror(char * msg) {
  fprintf(stderr, "YACC> Error at line %d. \n", yylineno); 
  fprintf(stderr, "This input won't happen in the testcases\n");
  exit(1);
}

