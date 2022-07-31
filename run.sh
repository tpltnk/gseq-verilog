#!/bin/bash

iverilog -g2012 gseq.sv && chmod +x ./a.out && ./a.out

rm a.out