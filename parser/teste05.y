%{

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
//#include "func.h"

extern int yylex();
extern int yyparse();
extern FILE* yyin;

int nclasses[20];
char *classes[20];
int rc[10];
int result1 = 0;
int result2 = 0;
int sizec = 0;
char *rts_;
char *local_;

void yyerror(const char* s);

%}

%union {
	int intval;
	double floatval;
	char *strval;
}

%token <strval> NAME
%token <strval> STRING
%token <intval> INTNUM
%token <intval> BOOL
%token <floatval> APPROXNUM

%type<strval> expression
%type<intval> date
%type<strval> class
%type<strval> expressions

%token BEFORE
%token AFTER
%token MEETS
%token MEETBY 
%token DURING
%token EQUALS
%token ANDOP
%token OROP
%token LPAREN
%token RPAREN
%token COMA
%token DOT
%token MINUS
%token NEWLINE

%left OROP 
%left ANDOP
%left '|'
%left '&'
%nonassoc UMINUS

%start ste_list

%%

ste_list: 
  | ste_list ste 
;

ste: NEWLINE 
  | args COMA expressions NEWLINE { printf("%s", $3);}
;

expressions: expression { $$ = $1; }
  | expressions ANDOP expression {
    int len=0;
    len = strlen($1) + strlen($3) + 2;
    $$ = malloc(len + 1);
    strcpy($$, $1);
    strcat($$, "&");
    strcat($$, $3);
  }
  | expressions OROP expression {
    int len=0;
    len = strlen($1) + strlen($3) + 2;
    $$ = malloc(len + 1);
    strcpy($$, $1);
    strcat($$, "|");
    strcat($$, $3);
  }
;

expression: BEFORE LPAREN class COMA date RPAREN { 
    int c1 = 0;
    for(int m=1;m<=sizec;m++){
      if(strcmp($3,classes[m])==0){
        c1 = nclasses[m];
      }
    }
    $$ = malloc(30);
    sprintf($$, "(vts==%i)&(%i>y)", c1, $5); 
    }
  | AFTER LPAREN class COMA date RPAREN { 
    int c1 = 0;
    for(int m=1;m<=sizec;m++){
      if(strcmp($3,classes[m])==0){
        c1 = nclasses[m];
      }
    }
    $$ = malloc(30);
    sprintf($$, "(vts==%i)&(%i<y)", c1, $5);
    }
  | MEETS LPAREN class COMA date RPAREN { 
    int c1 = 0;
    for(int m=1;m<=sizec;m++){
      if(strcmp($3,classes[m])==0){
        c1 = nclasses[m];
      }
    }
    $$ = malloc(31);
    sprintf($$, "(vts==%i)&(%i>=y)", c1, $5); 
    }
  | MEETBY LPAREN class COMA date RPAREN { 
    int c1 = 0;
    for(int m=1;m<=sizec;m++){
      if(strcmp($3,classes[m])==0){
        c1 = nclasses[m];
      }
    }
    $$ = malloc(31);
    sprintf($$, "(vts==%i)&(%i<=y)", c1, $5);
    }
  | DURING LPAREN class COMA date COMA date RPAREN { 
    int c1 = 0;
    for(int m=1;m<=sizec;m++){
      if(strcmp($3,classes[m])==0){
        c1 = nclasses[m];
      }
    }
    $$ = malloc(31);
    sprintf($$, "(vts==%i)&(%i<y)&(%i>y)", c1, $5, $7);
    }
  | EQUALS LPAREN class COMA date COMA date RPAREN { 
    int c1 = 0;
    for(int m=1;m<=sizec;m++){
      if(strcmp($3,classes[m])==0){
        c1 = nclasses[m];
      }
    }
    $$ = malloc(31);
    sprintf($$, "(vts==%i)&(%i<=y)&(%i>=y)", c1, $5, $7);
    }
;


args: arg 
    | args arg 
;

arg: INTNUM DOT class { 
  nclasses[$1] = $1;
  classes[$1] = $3;
  sizec = nclasses[$1];
  }
;


date: INTNUM { $$ = $1*10000; }
  | INTNUM MINUS INTNUM { $$ = ($1*10000) + ($3*100); }
  | INTNUM MINUS INTNUM MINUS INTNUM { $$ = ($1*10000) + ($3*100) + ($5);}
;

class: NAME { $$ = $1; }
  | STRING { $$ = $1; }
;


%%

int main() {
	yyin = stdin;

	do { 
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}