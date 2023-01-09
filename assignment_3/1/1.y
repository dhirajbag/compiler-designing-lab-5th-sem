/*

Dhiraj Bag, 001911001033
_________________________

Problem: Test the validity of simple expression involving operator +, -, * and /

Yacc Part:
__________

*/

%{
#include<stdio.h>
#include<stdlib.h>
%}

%token NUMBER ID NL
%left '+' '-'
%left '*' '/'

%%
stmt: exp NL {printf("valid expression\n"); exit(0);}
;
exp: exp '+' exp | exp '-' exp | exp '*' exp | exp '/' exp | '(' exp ')' | ID | NUMBER 
;
%%

int yyerror(char *msg)
{
 printf("Invalid expression\n");
 exit(0);
}

int main()
{
 printf("enter the expression: \n");
 yyparse();
 return 0;
}