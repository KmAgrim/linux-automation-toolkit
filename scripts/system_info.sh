#!/bin/bash

echo "===== SYSTEM INFORMATION ====="

echo ""

echo "Hostname:"
hostname

echo "Current User: $(whoami)"
echo 

echo "Uptime: $(uptime)"
echo

echo "Current System Date:"
date
echo 

echo "==== Curren Disk Usage ===="
df -h /
echo

echo "==== Current Memory Usage ===="
free -h
echo


echo "IP Address:"
ip -4 a | grep -w "inet" | grep -w "ens33"
