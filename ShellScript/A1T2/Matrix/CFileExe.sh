# #!/bin/bash

# # Ask for sudo password once
# echo "Enter your sudo password:"
# read -s SUDO_PASS

# # Define output files
# OUT1="perf_stat_cpu_output.txt"
# OUT2="perf_record_output.txt"
# OUT3="perf_stat_cache_output.txt"

# # Run commands with headings in separate terminals
# gnome-terminal -- bash -c "echo -e '\e[1;32m=== CPU Clock Event ===\e[0m'; echo $SUDO_PASS | sudo -S perf stat -e cpu-clock ./rowMajor > $OUT1 2>&1; cat $OUT1; exec bash"
# gnome-terminal -- bash -c "echo -e '\e[1;34m=== Profile Data Collection ===\e[0m'; echo $SUDO_PASS | sudo -S perf record -e cpu-clock,faults ./rowMajor > $OUT2 2>&1; cat $OUT2; exec bash"
# gnome-terminal -- bash -c "echo -e '\e[1;35m=== Cache Misses Measurement ===\e[0m'; echo $SUDO_PASS | sudo -S perf stat -e cache-misses ./rowMajor > $OUT3 2>&1; cat $OUT3; exec bash"

gcc -o columnMajor columnMajor.c 
gcc -o rowMajor rowMajor.c 
# gcc -o columnMajor_omp columnMajor.c -fopenmp 
# gcc -o rowMajor_omp rowMajor.c -fopenmp 

./columnMajor
./rowMajor
# ./columnMajor_omp
# ./rowMajor_omp
