#!/bin/bash

iverilog -g2012 gseq.v && chmod +x ./a.out && ./a.out

rm a.out