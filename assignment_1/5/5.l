/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   5. Lex Program that counts, identifies, and prints each operators and
   operands from a valid arithmetic expression.
*/

%{ 
    int num_operators = 0;
    int num_operands = 0;
%}

%%

\n return 0;

"+"|"-"|"*"|"/" { 
    num_operators++;
    printf("Operator : %s\n", yytext); 
} 
([0-9]*(\.)?[0-9]+)|([a-zA-Z][0-9]+?) { 
    num_operands++;
    printf("Operand : %s\n", yytext);
}

[\t() ] ;
. {printf("Invalid character received for an arithmetic expression."); exit(0);}

%%
  
  
int yywrap() 
{ 
    return 1; 
} 
int main() 
{ 
    printf("Enter the arithmetic expression: "); 
    yylex(); 
  
    printf(" Number of operators : %d \n Number of operands : %d\n", num_operators, num_operands); 
  
    return 0;
} 