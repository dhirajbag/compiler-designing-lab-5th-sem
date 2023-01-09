/*

Dhiraj Bag, 001911001033
_________________________

Problem: recognize strings „aaab‟,‟abbb‟,‟ab‟ and "a‟ using the grammar [Note: grammer not given in question.
Incomplete question].

Lex Part:
_________

*/
%{
#include<stdio.h>
#include<stdlib.h>
int n1 = 0;
int n2 = 0;
%}

%token A B NL
%%
stmt: As Bs NL {
    if(n1==3 && n2==1
    || n1==1 && n2==3
    || n1==1 && n2==1){
        printf("Valid string. [a%d b%d]\n", n1, n2);
    }
    else{
        printf("Invaid string! [a%d b%d]\n", n1, n2);
    }

    exit(0);
}
    | A NL { printf("Valid string. [a1]\n"); exit(0);}
 ;

As: A As {n1++;}
    | A {n1++;}
    ;

Bs: B Bs {n2++;}
    | B {n2++;}
    ;
%%
int yyerror(char *msg)
{
 printf("Invalid String!\n");
 exit(0);
}
main ()
{
 printf("Enter the String: \n");
 yyparse();
}