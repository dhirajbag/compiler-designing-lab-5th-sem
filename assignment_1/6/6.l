/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   6. Lex Program that converts an infix expression to a postfix expression.
*/

%{
    #define SIZE 100
    int precedence_cmp(char *op1, char *op2);
    char* stack[SIZE];
    char* output[SIZE];
    int top = -1;
    int len = 0;

    /* Precedence: '/' = '*' > '+' = '-'   */

%}

%%

\n return 0;

[0-9]*(\.)?[0-9]+ {strcpy(output[len++], yytext);}

[a-zA-Z][0-9]+? {strcpy(output[len++], yytext);}

[\t ] {/*skip*/;}

"(" { strcpy(stack[++top], "(");}

")" {
     while(top>=0 && strcmp(stack[top], "(") != 0){
        strcpy(output[len++], stack[top--]);
      }

      if(top==-1){
          printf("Parens do not match. Invalid expression.");
          exit(0);
      }
      else{
          top--; /* removed the "(" */
      }
    }

"/"|"*"|"+"|"-" {
                    if(top==-1 || strcmp(stack[top], "(")==0 || precedence_cmp(yytext, stack[top])==1){
                        //Precedence of op > Precedence of TOS
                        strcpy(stack[++top], yytext);
                    }
                    else{
                        while(top>=0 && strcmp(stack[top], "(") != 0 && precedence_cmp(yytext, stack[top]) <= 0 ){
                            strcpy(output[len++], stack[top--]);
                        }
                        strcpy(stack[++top], yytext);
                    }
                }

. {printf("Violates simple arithmetic expression.\nSupported operatos: \\, *,  +,  -\nSupported parens: (, )\nDoesn't support floating point numbers\n"); exit(0);}



%%

int yywrap(){return 1;}

int main(){

    for(int i=0; i<SIZE; i++){
        output[i] = (char*)malloc(10);
        stack[i] = (char*)malloc(10);
    }

    puts("[ Do NOT mention sign before operands ]");
    printf("Enter the infix expression: ");

    yylex();

    while(top>=0){
        if(strcmp(stack[top], "(")==0){
            printf("Parens do not match. Invalid expression.");
            exit(0);
        }
        strcpy(output[len++], stack[top--]);
    }

    printf("The postfix expression is:\n  ");
    for(int i=0; i<len; i++){
        printf("%s ", output[i]);
    }
    printf("\n\n");

    for(int i=0; i<SIZE; i++){
        free(output[i]);
        free(stack[i]);
    }

    return 0;
}

int precedence_cmp(char *op1, char *op2){

    if(strcmp(op1, op2)==0) return 0;

    if(strcmp(op1, "/")==0){
        if(strcmp(op2, "*")==0) return 0;
        return 1;
    }

    if(strcmp(op1, "*")==0){
        if(strcmp(op2, "/")==0) return 0;
        return 1;
    }

    if(strcmp(op1, "+")==0){
        if(strcmp(op2, "-")==0) return 0;
        return -1;
    }

    if(strcmp(op1, "-")==0){
        if(strcmp(op2, "+")==0) return 0;
        return -1;
    }
}