#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024  // Matrix size (1024x1024)

int A[N][N], B[N][N], C[N][N];  // Matrices

void multiply_matrices() {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];  // Column-wise access
            }
        }
    }
}

void initialize_matrices() {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = rand() % 10;
            B[i][j] = rand() % 10;
        }
    }
}

int main() {
    srand(time(NULL));
    initialize_matrices();

    clock_t start = clock();
    multiply_matrices();
    clock_t end = clock();

    printf("Execution Time: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
    return 0;
}
