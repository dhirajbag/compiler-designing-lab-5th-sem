/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   2. Lex Program that counts number of positive integers, negetive
   integers and fractions.
*/

%{
    int num_pos_int = 0;
    int num_neg_int = 0;
    int num_frac = 0; 
%}

%%

(\+)?[0-9]+ num_pos_int++;
-[0-9]+ num_neg_int++;
[+-]?[0-9]*(\.)[0-9]+ num_frac++;
\n return 0;
. ;

%%

int yywrap(){ return 1; }

int main(){
    printf("Enter the numbers: ");
    yylex();

    printf("\n Positive integers : %d\n Negetive integers : %d\n Fractional Numbers : %d\n\n", num_pos_int, num_neg_int, num_frac);
    return 0;
}