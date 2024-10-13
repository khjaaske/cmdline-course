#! /bin/bash

cat $1 |
sed -nE 's/[A-Z]/[a-z]/gp' |
tr -s '[:space:]' '\n' |
tr -d '[:punct:]' |
sort | 
uniq -c | 
sort -nr
