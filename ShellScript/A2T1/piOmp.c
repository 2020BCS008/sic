#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define NUM_POINTS 1000000000 // Number of random points

int main()
{
    int inside_circle = 0;
    double x, y, pi;

    // Initialize the random number generator
    srand(time(NULL));
    clock_t start = clock();
// Parallelize the loop using OpenMP
#pragma omp parallel private(x, y) shared(inside_circle)
    {
        int local_count = 0; // Local variable for counting points inside the circle

#pragma omp for
        for (int i = 0; i < NUM_POINTS; i++)
        {
            // Generate random point (x, y) in the range [0, 1)
            x = (double)rand() / RAND_MAX;
            y = (double)rand() / RAND_MAX;

            // Check if the point is inside the unit circle
            if (x * x + y * y <= 1.0)
            {
                local_count++;
            }
        }

// Use atomic operation to update the global count
#pragma omp atomic
        inside_circle += local_count;
    }

    // Estimate Pi
    pi = (double)inside_circle / NUM_POINTS * 4.0;
    clock_t end = clock();

    printf("Estimated Pi = %f\n", pi);
    printf("Execution Time: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);

    return 0;
}
