/*

Dhiraj Bag, 001911001033
_________________________

Problem: Test the validity of simple expression involving operator +, -, * and /

Lex Part:
________

*/

%{
#include"y.tab.h"
%}

%%
[0-9]+ {return NUMBER;}
[a-zA-Z][a-zA-Z0-9_]* {return ID;}
\n {return NL;}
. {return yytext[0];}
%%
