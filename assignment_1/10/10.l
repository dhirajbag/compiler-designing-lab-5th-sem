/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   10. Lex Program that validates an email address.
*/


%{
    int valid = 0;
%}

%%
\n return 0;
[^\n\t .@]+(\.[^\n\t .@]+)?@[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9](\.[a-zA-Z]+)? {valid=1;}
. {valid=0; return 0;} 

%%

int yywrap(){return 1;}

int main(){
    printf("Enter the email: ");
    yylex();

    if(valid)
        printf("\n=> Valid Email.\n\n");
    else
        printf("\n=> Invalid Email.\n\n");
    
    return 0;
}

