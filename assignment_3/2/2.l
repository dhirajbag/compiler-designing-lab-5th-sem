/*

Dhiraj Bag, 001911001033
_________________________

Problem: program to recognize nested IF control statements and display the no of level of nesting.

Lex Part:
_________

*/

%{
#include "y.tab.h"
%}

%%
"if" {return IF;}
[sS][0-9]* {return S;}
"<"|">"|"=="|"<="|">="|"!=" {return RELOP;}
[0-9]+ {return NUMBER;}
[a-z][a-zA-Z0-9_]* {return ID;}
\n {return NL;}
. {return yytext[0];}
%%