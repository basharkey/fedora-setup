#!/bin/bash

# enable cpu governor performance mode
for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $file; done

# tell host to only schedule new processes on host_cores
host_cores=0-7
systemctl set-property --runtime -- user.slice AllowedCPUs=$host_cores
systemctl set-property --runtime -- system.slice AllowedCPUs=$host_cores
systemctl set-property --runtime -- init.scope AllowedCPUs=$host_cores
