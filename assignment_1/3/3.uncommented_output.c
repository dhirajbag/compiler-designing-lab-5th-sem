



#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#define min(x, y) ((x < y) ? x : y)


typedef struct node
{
    int row;
    int col;
} node;




void subtractMinFromRows(int **cost, int num_rows, int num_cols);
void subtractMinFromCols(int **cost, int num_rows, int num_cols);
int findMinUncovered(int **cost, int num_rows, int num_cols, int *isLinedRow, int *isLinedCol);
node findOnlyNondiscardedZero(int **cost, int r1, int r2, int c1, int c2, int *isDiscardedRow, int *isDiscardedCol);
void printLines(int *isLinedRow, int *isLinedCol, int num_rows, int num_cols);
void makeNegetive(int **cost, int num_rows, int num_cols);

int *allocate_row(int n);
int **allocate_matrix_int(int num_rows, int num_cols);
void deallocate_matrix_int(int **matrix, int num_rows, int num_cols);
void input_row_int(int *row, int n);
void input_matrix_int(int **matrix, int num_rows, int num_cols);
void printMatrix(int **A, int r1, int r2, int c1, int c2);
void set_all_to(int *arr, int n, int val);
void copy_matrix_int(int **src, int **dest, int r1, int r2, int c1, int c2);


int main()
{   
    printf("Assignment Problem Solver: (- Dhiraj Bag, Roll: 001911001033) \n");
    printf("\nEach row represents a candidate, ie. num(candidates)=num(rows)\n");
    printf("Each column represents a job, ie. num(jobs)=num(columns)\n");

    int num_rows, num_cols;
    printf("\nEnter num(Rows) <space> num(Columns): ");
    scanf("%d %d", &num_rows, &num_cols);

    int **cost = allocate_matrix_int(num_rows, num_cols);

    printf("\nEnter Cost matrix(%dx%d) <in rows and columns> :\n", num_rows, num_cols);

    input_matrix_int(cost, num_rows, num_cols);

    int original_num_rows = num_rows;
    int original_num_cols = num_cols;

    int **originalCost = allocate_matrix_int(num_rows, num_cols);
    copy_matrix_int(cost, originalCost, 0, num_rows - 1, 0, num_cols - 1);

    int option;

    printf("\nEnter corresponding option number: \n\t1.Minimize Assignment Cost\n\t2.Maximize assignment cost(ie profit)\n\t: ");
    scanf("%d", &option);

    char isMaximization = (option == 2) ? 1 : 0;

    if (isMaximization)
        makeNegetive(cost, num_rows, num_cols);

    char isUnbalanced = 0;

    if (num_rows != num_cols)
    {
        isUnbalanced = 1;
        if (num_rows < num_cols)
        { 
            int **tmp = allocate_matrix_int(num_cols, num_cols);
            copy_matrix_int(cost, tmp, 0, num_rows - 1, 0, num_cols - 1);
            deallocate_matrix_int(cost, num_rows, num_cols);
            cost = tmp;
            num_rows = num_cols;
        }
        else
        { 
            int **tmp = allocate_matrix_int(num_rows, num_rows);
            copy_matrix_int(cost, tmp, 0, num_rows - 1, 0, num_cols - 1);
            deallocate_matrix_int(cost, num_rows, num_cols);
            cost = tmp;
            num_cols = num_rows;
        }
    }

    printf("\nEnter corresponding option number: \n\t1. Un-restricted assignment\n\t2. Restricted assignment\n\t: ");
    scanf("%d", &option);

    char isRestricted = (option == 2) ? 1 : 0;
    int numRestrictions = 0;

    if (isRestricted)
    {
        puts("Restricted problem: a candidate(row) cannot be assigned to a particular job(column) :\n");
        printf("Enter the number of restrictions: ");
        scanf("%d", &numRestrictions);

        printf("Enter the %d restricted row_number <space> column_number in %d lines(numbering starts from 1) : \n", numRestrictions, numRestrictions);
        int tmp = numRestrictions;
        while (tmp--)
        {
            int row, col;
            scanf("%d %d", &row, &col);
            row--;
            col--;
            cost[row][col] = INT_MAX >> 1;  
        }
    }

    subtractMinFromRows(cost, num_rows, num_cols);
    subtractMinFromCols(cost, num_rows, num_cols);

    while (1)
    {

        puts("\nDrawing lines on :");
        printMatrix(cost, 0, num_rows - 1, 0, num_cols - 1);

        int i, j;

        
        int isLinedRow[num_rows]; 
        int isLinedCol[num_cols]; 
        set_all_to(isLinedRow, num_rows, 0);
        set_all_to(isLinedCol, num_cols, 0);
        int numLines = 0;

        

        int isDiscardedRow[num_rows]; 
        int isDiscardedCol[num_cols]; 
        set_all_to(isDiscardedRow, num_rows, 0);
        set_all_to(isDiscardedCol, num_cols, 0);

        int **isAssigned = allocate_matrix_int(num_rows, num_cols);

        for (i = 0; i < num_rows; i++)
        {
            for (j = 0; j < num_cols; j++)
            {
                if (cost[i][j] == 0 && !isDiscardedCol[j])
                { 
                    isDiscardedRow[i] = 1;
                    isDiscardedCol[j] = 1;
                    isAssigned[i][j] = 1;
                    break;
                }
            }
        }

        int isMarkedRow[num_rows]; 
        int isMarkedCol[num_cols]; 
        set_all_to(isMarkedRow, num_rows, 0);
        set_all_to(isMarkedCol, num_cols, 0);

        int isNewlyMarkedRow[num_rows]; 
        int isNewlyMarkedCol[num_cols]; 
        set_all_to(isNewlyMarkedRow, num_rows, 0);
        set_all_to(isNewlyMarkedCol, num_cols, 0);

        int newlyMarkedCount = 0;

        for (i = 0; i < num_rows; i++)
            if (!isDiscardedRow[i])
            {
                isMarkedRow[i] = 1;
                isNewlyMarkedRow[i] = 1;
                newlyMarkedCount++;
            }

        char tmp_bit = 1;

        while (newlyMarkedCount > 0)
        {
            newlyMarkedCount = 0;

            if (tmp_bit)
            {   

                set_all_to(isNewlyMarkedCol, num_cols, 0); 

                int i;
                for (i = 0; i < num_rows; i++)
                {
                    if (isNewlyMarkedRow[i])
                    {
                        int j;
                        for (j = 0; j < num_cols; j++)
                        {
                            if (cost[i][j] == 0 && !isMarkedCol[j])
                            {
                                isMarkedCol[j] = 1;
                                isNewlyMarkedCol[j] = 1;
                                newlyMarkedCount++;
                            }
                        }
                    }
                }
            }

            else
            { 

                set_all_to(isNewlyMarkedRow, num_rows, 0); 

                int j;
                for (j = 0; j < num_cols; j++)
                {
                    if (isNewlyMarkedCol[j])
                    {

                        if (isDiscardedCol[j])
                        {
                            int i;
                            for (i = 0; i < num_rows; i++)
                            {
                                if (isAssigned[i][j] && !isMarkedRow[i])
                                { 
                                    isMarkedRow[i] = 1;
                                    isNewlyMarkedRow[i] = 1;
                                    newlyMarkedCount++;
                                }
                            }
                        }
                    }
                }
            }

            tmp_bit ^= 1; 
        }

        for (i = 0; i < num_rows; i++)
            if (!isMarkedRow[i])
            {
                isLinedRow[i] = 1;
                numLines++;
            }

        for (j = 0; j < num_cols; j++)
            if (isMarkedCol[j])
            {
                isLinedCol[j] = 1;
                numLines++;
            }

        printf("Drawn lines :\n");
        printLines(isLinedRow, isLinedCol, num_rows, num_cols);

        printf("\nMinimum number of lines = %d\n", numLines);

        

        
        if (numLines > num_rows)
        { 
            printf("Error: Unexpected behaviour : numLines > num_rows");
            return 0;
        }

        if(numLines < num_cols)
        { 
            printf("Optimal condition not reached. Doing necessary changes to cost matrix ...\n");

            int minUncovered = findMinUncovered(cost, num_rows, num_cols, isLinedRow, isLinedCol);

            

            for (i = 0; i < num_rows; i++)
            {
                for (j = 0; j < num_cols; j++)
                {

                    if (!(isLinedRow[i] || isLinedCol[j])) 
                        cost[i][j] -= minUncovered;

                    else if (isLinedRow[i] && isLinedCol[j])  
                        cost[i][j] += minUncovered;
                }
            }
        }

        
        
        
        
        
        
        
        
        
        deallocate_matrix_int(isAssigned, num_rows, num_cols);
        

        if (numLines == num_rows) 
            break;
    }

    
    puts("\n\nOptimal condition for cost matrix is reached...\n");

    

    int **isAssignedCell = allocate_matrix_int(num_rows, num_cols);
    int *isDiscardedRow = allocate_row(num_rows);
    int *isDiscardedCol = allocate_row(num_cols);
    int numAssigned = 0;

    while (numAssigned < num_rows)
    {
        char shouldCheckAgain = 1;
        int i, j;

        while (shouldCheckAgain)
        {
            shouldCheckAgain = 0;

            
            for (i = 0; i < num_rows; i++)
            {
                if (!isDiscardedRow[i])
                {
                    node cell = findOnlyNondiscardedZero(cost, i, i, 0, num_cols - 1, isDiscardedRow, isDiscardedCol);

                    if (cell.row != -1)
                    { 
                        isAssignedCell[cell.row][cell.col] = 1;
                        isDiscardedRow[cell.row] = 1;
                        isDiscardedCol[cell.col] = 1;
                        numAssigned++;
                        shouldCheckAgain = 1;
                    }
                }
            }

            
            for (j = 0; j < num_cols; j++)
            {
                if (!isDiscardedCol[j])
                {
                    node cell = findOnlyNondiscardedZero(cost, 0, num_rows - 1, j, j, isDiscardedRow, isDiscardedCol);

                    if (cell.row != -1)
                    { 
                        isAssignedCell[cell.row][cell.col] = 1;
                        isDiscardedRow[cell.row] = 1;
                        isDiscardedCol[cell.col] = 1;
                        numAssigned++;
                        shouldCheckAgain = 1;
                    }
                }
            }
        }

        if (numAssigned < num_rows)
        {
            
            for (i = 0; i < num_rows; i++)
            {
                if (!isDiscardedRow[i])
                {
                    for(j=0; j<num_cols; j++){
                        if(cost[i][j]==0 && !isDiscardedCol[j]){
                            isAssignedCell[i][j] = 1;
                            isDiscardedRow[i] = 1;
                            isDiscardedCol[j] = 1;
                            numAssigned++;
                            break;
                        }
                    }
                }
            }
        }
    }




    printf("\nThe assignment as a matrix(includes dummy rows/cols, if any) is (1 indicates assigned cell):\n");
    printMatrix(isAssignedCell, 0, num_rows - 1, 0, num_cols - 1);


    int assignmentCost = 0;
    int i, j;
    puts("\n\n\n  => The final optimal assignment (excludes any dummy rows/cols) is : \n");
    for (i = 0; i < original_num_rows; i++)
    {
        for (j = 0; j < original_num_cols; j++)
        {
            if (isAssignedCell[i][j])
            {
                assignmentCost += originalCost[i][j];

                printf("\tRow %d => Column %d \n", i + 1, j + 1);
            }
        }
    }

    printf("\n  => Total assignment cost (profit if maximization) is = %d\n", assignmentCost);


    
    free(isDiscardedRow);
    free(isDiscardedCol);
    deallocate_matrix_int(isAssignedCell, num_rows, num_cols);
    deallocate_matrix_int(cost, num_rows, num_cols);
    deallocate_matrix_int(originalCost, original_num_rows, original_num_cols);


    printf("\nYou have reached the end of the program. Press enter to exit.");
    getchar(); getchar();

    return 0;
}

void subtractMinFromRows(int **cost, int num_rows, int num_cols)
{

    int i;

    for (i = 0; i < num_rows; i++)
    {
        int minVal = INT_MAX;

        int j;
        for (j = 0; j < num_cols; j++)
            minVal = min(cost[i][j], minVal);

        for (j = 0; j < num_cols; j++)
            cost[i][j] -= minVal;
    }
}

void subtractMinFromCols(int **cost, int num_rows, int num_cols)
{

    int j;

    for (j = 0; j < num_cols; j++)
    {
        int minVal = INT_MAX;

        int i;
        for (i = 0; i < num_rows; i++)
            minVal = min(cost[i][j], minVal);

        for (i = 0; i < num_rows; i++)
            cost[i][j] -= minVal;
    }
}

node findOnlyNondiscardedZero(int **cost, int r1, int r2, int c1, int c2, int *isDiscardedRow, int *isDiscardedCol)
{
    node cell = {-1, -1};
    int count = 0;

    int i, j;
    for (i = r1; i <= r2; i++)
    {
        for (j = c1; j <= c2; j++)
        {
            if (cost[i][j] == 0 && !(isDiscardedRow[i] || isDiscardedCol[j]))
            {
                cell.row = i;
                cell.col = j;
                count++;
            }
        }
    }

    if (count != 1)
    {
        cell.row = cell.col = -1;
    }

    return cell;
}

int findMinUncovered(int **cost, int num_rows, int num_cols, int *isLinedRow, int *isLinedCol)
{

    int minVal = INT_MAX;

    int i, j;
    for (i = 0; i < num_rows; i++)
    {
        for (j = 0; j < num_cols; j++)
        {
            if (!(isLinedRow[i] || isLinedCol[j]))
                minVal = min(cost[i][j], minVal);
        }
    }

    return minVal;
}



void printLines(int *isLinedRow, int *isLinedCol, int num_rows, int num_cols)
{

    int i, j;

    for (i = 0; i < num_rows; i++)
    {
        for (j = 0; j < num_cols; j++)
        {
            if (isLinedRow[i] && isLinedCol[j])
                printf("|");
            else if (isLinedRow[i])
                printf("----");
            else if (isLinedCol[j])
                printf("|");
            else
                printf(" *  ");
        }
        printf("\n");
    }
}

void printMatrix(int **A, int r1, int r2, int c1, int c2)
{
    int i, j;
    for (int i = r1; i <= r2; i++)
    {
        for (int j = c1; j <= c2; j++)
        {
            printf("%d\t", A[i][j]);
        }
        printf("\n");
    }
}

int **allocate_matrix_int(int num_rows, int num_cols)
{
    int **matrix = (int **)malloc(num_rows * sizeof(int *));

    int i, j;
    for (i = 0; i < num_rows; i++)
    {
        matrix[i] = (int *)malloc(num_cols * sizeof(int));

        for (j = 0; j < num_cols; j++)
            matrix[i][j] = 0;
    }

    return matrix;
}

int *allocate_row(int n)
{
    int *row = (int *)malloc(n * sizeof(int));
    int i;
    for (i = 0; i < n; i++)
        row[i] = 0;

    return row;
}

void deallocate_matrix_int(int **matrix, int num_rows, int num_cols)
{
    int i;
    for (i = 0; i < num_rows; i++)
    {
        free(matrix[i]);
    }

    free(matrix);
}

void input_row_int(int *row, int n)
{
    int i;
    for (i = 0; i < n; i++)
        scanf("%d", &row[i]);
}

void input_matrix_int(int **matrix, int num_rows, int num_cols)
{
    int i, j;
    for (i = 0; i < num_rows; i++)
    {
        input_row_int(matrix[i], num_cols);
    }
}

void makeNegetive(int **cost, int num_rows, int num_cols)
{
    int i, j;

    for (i = 0; i < num_rows; i++)
    {
        for (j = 0; j < num_cols; j++)
        {
            cost[i][j] *= -1;
        }
    }
}


void set_all_to(int *arr, int n, int val)
{
    int i;
    for (i = 0; i < n; i++)
        arr[i] = val;
}

void copy_matrix_int(int **src, int **dest, int r1, int r2, int c1, int c2)
{
    int i, j;
    for (i = r1; i <= r2; i++)
    {
        for (j = c1; j <= c2; j++)
        {
            dest[i][j] = src[i][j];
        }
    }
}
