/*

Dhiraj Bag, 001911001033
_________________________

Problem: recognize valid variable, which starts with a letter, followed by any number of letters or digits.

Yacc Part:
_________

*/
%{
    #include<stdio.h>
    int valid=1;
%}

%token digit letter

%%

start: letter s

s:     letter s

      | digit s

      |

      ;

%%

int yyerror()
{

    printf("\nNot a valid variable!\n");

    valid=0;

    return 0;

}

int main()
{
    printf("\nEnter the variable: ");
    yyparse();

    if(valid)
    {
        printf("\nValid variable.\n");
    }
}