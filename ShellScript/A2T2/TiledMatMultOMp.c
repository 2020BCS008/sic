#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define N 1024  // Matrix size (1024x1024)
#define TILE_SIZE 64  // Tile size (can be adjusted)

int A[N][N], B[N][N], C[N][N];  // Matrices

// Matrix multiplication using a tiled approach
void multiply_matrices_tiled() {
    #pragma omp parallel for collapse(2)
    for (int i = 0; i < N; i += TILE_SIZE) {  // Loop over rows of tiles
        for (int j = 0; j < N; j += TILE_SIZE) {  // Loop over columns of tiles
            for (int k = 0; k < N; k += TILE_SIZE) {  // Loop over common dimension of tiles
                // Multiply tiles
                for (int ii = i; ii < i + TILE_SIZE && ii < N; ii++) {
                    for (int jj = j; jj < j + TILE_SIZE && jj < N; jj++) {
                        for (int kk = k; kk < k + TILE_SIZE && kk < N; kk++) {
                            C[ii][jj] += A[ii][kk] * B[kk][jj];
                        }
                    }
                }
            }
        }
    }
}

// Initialize matrices A and B with random values
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
    multiply_matrices_tiled();
    clock_t end = clock();

    printf("Execution Time: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
    return 0;
}
