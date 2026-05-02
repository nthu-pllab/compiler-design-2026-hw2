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
  char * strVal;
  char chVal;
}

%%

start:
     decl_or_def_s {
       printf("%s", $1);
       free((char *)($1));
     }
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

