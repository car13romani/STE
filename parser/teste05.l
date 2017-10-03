%option noyywrap case-insensitive

%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdarg.h>


#define YY_DECL int yylex()

#include "teste05.tab.h"


%}

%%


[ \t]	; // ignore all whitespace
\n		{return NEWLINE;}

 /* keywords */

BEFORE	{ return BEFORE; }
AFTER	{ return AFTER; }
MEETS	{ return MEETS; }
MEETBY	{ return MEETBY; }
DURING	{ return DURING; }
EQUALS	{ return EQUALS; }

"-"	{ return MINUS; }
AND 	{ return ANDOP; }
OR 		{ return OROP; }
"&"	{ return ANDOP; }
"|"    { return OROP; }


"("		{ return LPAREN; }
")"		{ return RPAREN; }
","		{ return COMA; }
"."		{ return DOT; }



   /* numbers */

-?[0-9]+	        { yylval.intval = atoi(yytext); return INTNUM; } 

-?[0-9]+"."[0-9]* |
-?"."[0-9]+	|
-?[0-9]+E[-+]?[0-9]+	|
-?[0-9]+"."[0-9]*E[-+]?[0-9]+ |
-?"."[0-9]*E[-+]?[0-9]+	{ yylval.floatval = atof(yytext) ;
                                  return APPROXNUM; }
  
 /* booleans */
TRUE	{ yylval.intval = 1; return BOOL; }
UNKNOWN	{ yylval.intval = -1; return BOOL; }
FALSE	{ yylval.intval = 0; return BOOL; }


   /* strings */

'(\\.|''|[^'\n])*'	|
\"(\\.|\"\"|[^"\n])*\"  { yylval.strval = strdup(yytext); return STRING; }

 
[A-Za-z][A-Za-z0-9_]*	{ yylval.strval = strdup(yytext);
                          return NAME; }
`[^`/\\.\n]+`           { yylval.strval = strdup(yytext+1);
                          yylval.strval[yyleng-2] = 0;
                          return NAME; }

%%
