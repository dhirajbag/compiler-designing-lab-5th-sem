/*

Dhiraj Bag, 001911001033
_________________________

Problem: recognize strings „aaab‟,‟abbb‟,‟ab‟ and "a‟ using the grammar [Note: grammer not given in question.
Incomplete question].

Lex Part:
_________

*/
%{
 #include "y.tab.h"
%}
%%
[aA] { return A; }
[bB] { return B; }
\n { return NL ;}
. { return yytext[0]; }
%%