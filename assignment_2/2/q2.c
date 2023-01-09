/*
   Dhiraj Bag
   Roll: 001911001033
   BE in IT - 3rd Year 1st Semester
   Jadavpur University

   2. Converting NFA to DFA

*/


#include <stdio.h>
#include <string.h>
#include <math.h>

int dfa[100][2][100] = {0};

int main()
{
    printf("\n[ Note: In output, state_i will be written as 2^i ]\n");
    printf("Alphabet: {'0', '1'}\n");

    int st, fin, in;
    int f[10];
    int i, j = 3, s = 0, final = 0, flag = 0, curr1, curr2, k, l;
    int c;

    printf("\nEnter the Number Of States: ");
    scanf("%d", &st);

    printf("\nAssume States are numbered as follows: ");
    for (i = 0; i < st; i++)
    {
        printf("%d ", i);
    }
    printf("\n");

    printf("\nEnter Initial State Number: ");
    scanf("%d", &in);

    printf("\nEnter the Number Of Final States: ");
    scanf("%d", &fin);

    printf("\nEnter the Number(s) representing the Final State(s): ");
    for (i = 0; i < fin; i++)
    {
        scanf("%d", &f[i]);
    }

    int p, q, r, rel;

    printf("\nEnter the Number Of Rules according to NFA\n(Note: Do not count rules including Phi): ");
    scanf("%d", &rel);

    printf("\nEnter the Rules: (Format: <state> <input> <next_state> )\n");
    for (i = 0; i < rel; i++)
    {
        printf("Rule#%d => ", i);
        scanf("%d %d %d", &p, &q, &r);
        if (q == 0)
            dfa[p][0][r] = 1;
        else
            dfa[p][1][r] = 1;
    }

    in = pow(2, in);

    i = 0;

    printf("\nSolving according to DFA:\n");
    printf("Table for DFA is given below:\n");
    printf("\n[Note: State_i is replaced by 2^i. And Union of State_i and State_j is replaced by (2^i + 2^j)]\n");

    printf("Encoded_State\tInput\tEncoded_Next_State\n");

    int x = 0;
    for (i = 0; i < st; i++)
    {
        for (j = 0; j < 2; j++)
        {
            int stf = 0;
            for (k = 0; k < st; k++)
            {
                if (dfa[i][j][k] == 1)
                    stf = stf + pow(2, k);
            }

            printf("      %d     -->   %d   =>     %d\n", (int)(pow(2, i)), j, stf);

        }
    }

    return 0;
}