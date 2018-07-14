#!bin/bash
echo ruok | nc `hostname` 2181 | grep -q imok
