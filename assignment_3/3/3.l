/*

Dhiraj Bag, 001911001033
_________________________

Problem: recognize valid variable, which starts with a letter, followed by any number of letters or digits.

Lex Part:
_________

*/

%{
    #include "y.tab.h"
%}

%%

[a-zA-Z_][a-zA-Z_0-9]* return letter;

[0-9]                  return digit;

.                      return yytext[0];

\n                     return 0;

%%

int yywrap()

{
    return 1;
}