#!/bin/bash

# Measure CPU clock cycles
echo "Measuring CPU clock cycles..."
sudo perf stat -e cpu-clock ./TiledMatMultOMp

# Record performance data including CPU clock cycles and memory access faults
echo "Recording performance data (CPU clock cycles and faults)..."
sudo perf record -e cpu-clock,faults ./TiledMatMultOMp

# Track cache misses
echo "Tracking cache misses..."
sudo perf stat -e cache-misses ./TiledMatMultOMp

echo "Performance analysis complete."