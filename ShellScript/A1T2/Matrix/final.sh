#!/bin/bash

# sudo password once access
echo "Enter your sudo password:"
read -s SUDO_PASS

# output files for rowMajor
OUT4="perf_stat_cpu_rowMajor_output.txt"
OUT5="perf_record_rowMajor_output.txt"
OUT6="perf_stat_cache_rowMajor_output.txt"

# output files for columnMajor
OUT1="perf_stat_cpu_columnMajor_output.txt"
OUT2="perf_record_columnMajor_output.txt"
OUT3="perf_stat_cache_columnMajor_output.txt"

# Running rowMajor commands
gnome-terminal -- bash -c "echo -e '\e[1;32m=== CPU Clock Event (Row Major) ===\e[0m'; echo $SUDO_PASS | sudo -S perf stat -e cpu-clock ./rowMajor > $OUT4 2>&1; cat $OUT4; exec bash"
gnome-terminal -- bash -c "echo -e '\e[1;34m=== Profile Data Collection (Row Major) ===\e[0m'; echo $SUDO_PASS | sudo -S perf record -e cpu-clock,faults ./rowMajor > $OUT5 2>&1; cat $OUT5; exec bash"
gnome-terminal -- bash -c "echo -e '\e[1;35m=== Cache Misses Measurement (Row Major) ===\e[0m'; echo $SUDO_PASS | sudo -S perf stat -e cache-misses ./rowMajor > $OUT6 2>&1; cat $OUT6; exec bash"

# Wait for Row Major to finish 
sleep 10  
# Running columnMajor
gnome-terminal -- bash -c "echo -e '\e[1;32m=== CPU Clock Event (Column Major) ===\e[0m'; echo $SUDO_PASS | sudo -S perf stat -e cpu-clock ./columnMajor > $OUT1 2>&1; cat $OUT1; exec bash"
gnome-terminal -- bash -c "echo -e '\e[1;34m=== Profile Data Collection (Column Major) ===\e[0m'; echo $SUDO_PASS | sudo -S perf record -e cpu-clock,faults ./columnMajor > $OUT2 2>&1; cat $OUT2; exec bash"
gnome-terminal -- bash -c "echo -e '\e[1;35m=== Cache Misses Measurement (Column Major) ===\e[0m'; echo $SUDO_PASS | sudo -S perf stat -e cache-misses ./columnMajor > $OUT3 2>&1; cat $OUT3; exec bash"
