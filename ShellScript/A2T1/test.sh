#!/bin/bash

# Measure CPU clock cycles
echo "Measuring CPU clock cycles..."
sudo perf stat -e cpu-clock ./piOmp

# Record performance data including CPU clock cycles and memory access faults
echo "Recording performance data (CPU clock cycles and faults)..."
sudo perf record -e cpu-clock,faults ./piOmp
# Track cache misses
echo "Tracking cache misses..."
sudo perf stat -e cache-misses ./piOmp

echo "Performance analysis complete."