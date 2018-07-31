#!/bin/bash

sar -u 60 5 | awk '{ if (int($9)>80) { i=i+1 } if (int($9)<80) { print $9 } if (i==5) { print "Sending email" }}'
