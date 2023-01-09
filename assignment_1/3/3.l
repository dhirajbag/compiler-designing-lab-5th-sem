/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   3. Lex Program to count number of commen lines and words inside
   a C program given as input. (Also create a C file with the comments removed)
*/

%{
    int num_words = 0;
    int num_lines = 0;
    void process_text(char *text, int len, int *num_words, int *num_lines, int single_line);
%}

%%
"/*"([^*]*(\*[^/])*)*"*/" {process_text(yytext, yyleng, &num_words, &num_lines, 0);}

"//".* {process_text(yytext, yyleng, &num_words, &num_lines, 1);}

%%

int yywrap(){return 1;}

int main(){
    
    char *file_path = "3.uncommented_output.c";
    yyout = fopen(file_path, "w");
    if(yyout==NULL) {
        perror("Failed to create output_file");
        exit(0);
    }
    yylex();

    printf(" Number of lines commented : %d\n Number of words commented : %d\n", num_lines, num_words);

    fclose(yyout);
    return 0;
}

void process_text(char *text, int len, int *num_words, int *num_lines, int single_line){
    int n_words = 0;
    int n_lines = 1;
    int start = 2;
    int end = single_line ? len-1 : len-3; //(text[len-1]=='\n' ? len-4 : len-3);
    int word_started = 0;
    for(int i=start; i <= end; i++){
        if(text[i]==' ' || text[i]=='\t' || text[i]=='\n'){
            word_started = 0;

            if(text[i]=='\n') n_lines++;
        }
        else{
            if(!word_started){
                word_started = 1;
                n_words ++;
            }
        }
    }

    *num_words += n_words;
    *num_lines += n_lines;
}