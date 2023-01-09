/*

Dhiraj Bag, 001911001033
_________________________

Problem: code to evaluate an arithmetic expression involving operators +,-,* and /.

Lex Part:
_________

*/

%{
#include"y.tab.h"
extern yylval;
%}

%%
[0-9]+ { yylval=atoi(yytext); return NUMBER;}
[a-zA-Z][a-zA-Z0-9_]* {return ID;}
\n {return 0;}
[ \t]+ ;
. {return yytext[0];}
%%
