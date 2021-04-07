#!/bin/bash
set -e

appMainClass=$1

target_name = `jps -l | grep -i ${appMainClass} | awk '{print $2}' | sort -n -k 1 | head -n 1`
echo target_name
