/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   1. Lex Program that counts number of vowels and consonants 
   in a given string also shows count of each vowel.
*/

%{
    int num_vowel = 0;
    int num_consonant = 0;
    int num_a = 0;
    int num_e = 0;
    int num_i = 0;
    int num_o = 0;
    int num_u = 0;
%}

%%
a|A {num_a++; num_vowel++;}
e|E {num_e++; num_vowel++;}
i|I {num_i++; num_vowel++;}
o|O {num_o++; num_vowel++;}
u|U {num_u++; num_vowel++;}

[a-zA-Z] {num_consonant++;}

\n return 0;
. ;

%%
int yywrap(){ return 1;}
int main(){
    printf("Enter the string: ");
    yylex();

    printf("\nNumber of vowels : %d and number of consonants : %d\n", num_vowel, num_consonant);
    printf("Number of 'a' or 'A' : %d\n", num_a);
    printf("Number of 'e' or 'E' : %d\n", num_e);
    printf("Number of 'i' or 'I' : %d\n", num_i);
    printf("Number of 'o' or 'O' : %d\n", num_o);
    printf("Number of 'u' or 'U' : %d\n", num_u);

    return 0;
}


