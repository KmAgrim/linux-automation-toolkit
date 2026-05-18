#!/bin/bash

echo "===== SYSTEM INFORMATION ====="

echo ""

echo "Hostname:"
hostname

echo "Current User:"
whoami

echo "Uptime:"
uptime

echo "Current System Date:"
date -u

echo "Curren Disk Usage:"
df -h

echo "Current Memory Usage:"
free -h

echo "Current User:"
who -Hm

