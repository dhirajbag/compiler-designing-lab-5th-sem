/*

Dhiraj Bag, 001911001033
_________________________

Problem: program to recognize nested IF control statements and display the no of level of nesting.

Yacc Part:
__________

*/

%{
#include<stdio.h>
#include<stdlib.h>
int count=0;
%}

%token IF RELOP S NUMBER ID NL

%%
stmt: if_stmt NL {printf("Number of nested if statements = %d\n",count);exit(0);}
;
if_stmt: IF'('cond')''{'if_stmt'}' {count++;}
          |S
;
cond: x RELOP x 
;
x: ID | NUMBER
;
%%

int yyerror(char *msg)
{
printf("Invalid Statement.\n");
exit(0);
}

main()
{
printf("Enter the statement: \n");
yyparse();
}