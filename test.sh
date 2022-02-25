#!/bin/bash
cpu=$1
it=$2
for i in $(seq 1 $it) ; do
#for i in $(seq 1 10000) ; do
  echo -n "$i "
  for j in $(seq 1 500) ; do
    taskset --cpu-list $cpu wget -O /dev/null http://172.17.0.2 2>/dev/null
  done
done
echo
