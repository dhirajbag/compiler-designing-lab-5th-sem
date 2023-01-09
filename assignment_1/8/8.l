/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   8. Lex Program that implements 'wc' command (for single file)
   and 'mwc' command (for multiple files) that reads number of lines,
   characters, words in a file.
*/

%{
    int num_chars = 0;
    int num_words = 0;
    int num_lines = 1;
%}


%%

\n {num_lines++;}

[^\t\n ]+ {num_words += 1; num_chars += yyleng;}

. {num_chars++;}


%%

int yywrap(){return 1;}
void print_usage(){
    printf("Wrong format! Please follow the usage:\n");
    printf("For single file: ./main -wc file_path\n");
    printf("\t eg. ./main -wc sample.txt\n");
    printf("For multiple files: ./main -mwc file1_path file2_path file3_path ...\n");
    printf("\t eg. ./main -mwc sample1.txt sample2.txt sample3.txt\n\n");
}
int main(int argc, char **argv){

    /*  Note: Newline character is not counted as a character for output
        Usage:
            ./main -wc input.txt
            ./main -mwc in1.txt in2.txt in3.txt

    */
    
    if(argc <= 2){
        print_usage();
        exit(0);
    }

    if(strcmp(argv[1], "-wc")==0){

        if(argc > 3){
            print_usage();
            exit(0);
        }

        yyin = fopen(argv[2], "r");

        if(yyin==NULL){
            perror("Couldn't open file");
            exit(0);
        }

        yylex();
        fclose(yyin);
        printf("Number of lines : %d\nNumber of words : %d\nNumber of characters : %d\n", num_lines, num_words, num_chars);
        return 0;

    }

    else if(strcmp(argv[1], "-mwc")==0){
        for(int i=2; i<argc; i++){
            yyin = fopen(argv[i], "r");

            if(yyin==NULL){
                perror("Couldn't open file ");
                exit(0);
            }

            yylex();

            fclose(yyin);

            printf("File : %s => \n", argv[i]);
            printf("Number of lines : %d\nNumber of words : %d\nNumber of characters : %d\n\n", num_lines, num_words, num_chars);

            num_chars =  0;
            num_words = 0;
            num_lines = 1;
        }

        return 0;
    }

    else{
        print_usage();
        exit(0);
    }

    
}

