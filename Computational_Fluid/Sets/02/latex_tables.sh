#!/bin/bash

# add "&" at the end of each line 
sed -i 's/$/\&/' common.txt

# add "\\" at the end of each line 
sed -i 's/$/\\\\/g' values.txt
sed -i 's/$/\\\\/g' errors.txt

# file tables 
paste common.txt values.txt > tableVal.txt
paste common.txt errors.txt > tableErr.txt
