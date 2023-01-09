/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   4. Lex Program that counts number of scanf and printf statements in a c
   program also creates a new c file with printf replaced by writef and scanf
   replaced by readf.
*/


%{
    int num_printf = 0;
    int num_scanf = 0;

%}


%%

printf {num_printf++; fprintf(yyout, "writef");}
scanf {num_scanf++; fprintf(yyout, "readf");}


%%

int yywrap(){return 1;}

int main(){
    char *file_path = "4.output_file.c";
    yyout = fopen(file_path, "w");

    if(yyout==NULL){
        perror("Failed to create output file");
        exit(0);
    }

    yylex();
    fclose(yyout);
    printf("Number of scanf statements : %d\n Number of printf statements : %d\n", num_scanf, num_printf);

    return 0;
}