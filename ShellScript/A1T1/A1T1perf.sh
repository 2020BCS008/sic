#!/bin/bash

# Run perf list and save output
echo "Collecting perf events..."
sudo perf list > perf_events.txt

sleep 2  # Wait for the command to complete

# Extract and classify events
grep "\[Hardware event\]" perf_events.txt > hardware_events.txt
grep "\[Software event\]" perf_events.txt > software_events.txt
grep "\[Tool event\]" perf_events.txt > tool_events.txt


#sleep 2 # Short delay before opening terminals

# Open categorized events in separate labeled terminals
gnome-terminal -- bash -c "echo '### Hardware Events ###'; cat hardware_events.txt; read -p 'Press Enter to close...'"

#sleep 2 
gnome-terminal -- bash -c "echo '### Software Events ###'; cat software_events.txt; read -p 'Press Enter to close...'"

#sleep 2 
gnome-terminal -- bash -c "echo '### Tool Events ###'; cat tool_events.txt; read -p 'Press Enter to close...'"

#sleep 2 
#gnome-terminal -- bash -c "echo '### Kernel PMU Events ###'; cat kernel_pmu_events.txt; read -p 'Press Enter to close...'"

