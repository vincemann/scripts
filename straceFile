#!/bin/bash
#only file syscalls
#also watch transitive processes 
#write to output file
strace -e trace=file -f -o stracedProcessLog.txt "$1"
