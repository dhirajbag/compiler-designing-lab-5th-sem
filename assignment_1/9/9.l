/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   9. Lex Program that validates a password for strongness.
*/

%{
    int num_chars = 0;
    int min_len = 8;
    int max_len = 15;
    int num_ucase = 0;
    int num_lcase = 0;
    int num_digit = 0;
    int num_spcl = 0;

%}


%%
[\n\t ] return 0;
[A-Z] {num_chars++; num_ucase++;}
[a-z] {num_chars++; num_lcase++;}
[0-9] {num_chars++; num_digit++;}
[~`!@#$%^&*()_\-+={[}\]|\\:;"'<,>.?/] {num_chars++; num_spcl++;}
. {num_chars++;}

%%

int yywrap(){return 1;}

void print_unsatisfied_contions(int num_chars,int min_len,int max_len,int num_ucase,int num_lcase,int num_digit,int num_spcl){
    if(num_chars < min_len)
        printf(" - Minimum length of password should be %d\n", min_len);

    if(num_chars > max_len)
        printf(" - Maximum length of password should be %d\n", max_len);
    
    if(num_ucase==0)
        puts(" - Must contain at least one UPPER CASE character (A-Z)");
    
    if(num_lcase==0)
        puts(" - Must contain at least one lower case character (a-z)");
    
    if(num_digit==0)
        puts(" - Must contain at least one digit (0-9)");
    
    char *spcl_chars = "[ ~ ` ! @ # $ % ^ & * ( ) _ - + = { [ } ] | \\ : ; \" ' < , > . ? / ]";
    
    if(num_spcl==0)
        printf(" - Must contain at least one of these following special characters:\n   %s\n", spcl_chars);
    
}

int main(){
    printf("Enter the password: ");
    yylex();

    if(num_chars>=min_len && num_chars <=max_len && num_lcase && num_ucase && num_digit && num_spcl){
        printf("=> Password is valid.\n");
        return 0;
    }

    printf("=> Invalid Password!\n\nFollowing coditions are not met:\n");
    print_unsatisfied_contions(num_chars, min_len, max_len, num_ucase, num_lcase, num_digit, num_spcl);
    printf("\n");
    return 0;
}