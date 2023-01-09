/* Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   7. Lex Program that takes as input a file containing some identifiers, 
   stores new identifiers into a table (hash table using hashing). If the
   encountered identifier is already present in the hash table, it produces
   an error messaage identifying that.
*/


%{
    #define SIZE 1000
    #define max_identifier_size 50
    typedef struct listNode{
        char *identifier;
        struct listNode *next;
    } listNode;

    typedef struct table{
        listNode* arr[SIZE];
    } table;

    table* get_table();
    int insert(table *tbl, char *text);
    void clear_table(table *tbl);
    void clear_list(listNode *list);

    table *tbl = NULL;
    int cur_line = 1;
    int curr_char = 1; 

%}


%%

[a-zA-Z_]+[0-9]+? { /*identifier*/
    if(insert(tbl, yytext)==0){
        printf("[Error @ line: %d character: %d] identifier '%s' already present.\n",cur_line, curr_char, yytext);
    }

    curr_char += yyleng;
}

\n {cur_line++ ; curr_char = 1; }
. {curr_char++;}


%%
int yywrap() {return 1;}

int main(){
    tbl = get_table();
    yylex();

    clear_table(tbl);
    return 0;
}

table* get_table(){
    table *tbl = (table*) malloc(sizeof(table));
    int i;
    for(i=0; i<SIZE; i++){
        tbl->arr[i] = NULL;
    }
    return tbl;
}

int hash(char *str){
    int value = 0;
    int p = 13;
    int k = 1;

    int i=0;

    while(str[i++] != '\0'){
        value = (value +k*str[i])%SIZE;
        k *= p;
    }


    return value;
}

int find(listNode *list, char *text){
    while(list != NULL){
        if(strcmp(list->identifier, text)==0)
            return 1;
        list = list->next;
    }
    return 0;
}

int insert(table *tbl, char *text){
    int bucket = hash(text)%SIZE;

    if(find(tbl->arr[bucket], text)) return 0;

    listNode *newNode = (listNode*) malloc(sizeof(listNode));
    newNode->identifier = (char*) malloc(max_identifier_size);
    strcpy(newNode->identifier, text);

    newNode->next = tbl->arr[bucket];
    tbl->arr[bucket] = newNode;

    return 1;
}

void clear_table(table *tbl){
    for(int i=0 ; i<SIZE; i++){
        clear_list(tbl->arr[i]);
    }
    
    free(tbl);
}

void clear_list(listNode *list){
    if(list==NULL) return;

    while(list != NULL){
        listNode *node_ptr = list;
        list = list->next;

        free(node_ptr->identifier);
        free(node_ptr);
    }
}
