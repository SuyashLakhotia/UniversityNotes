#!/bin/bash

pandoc -H format.sty -V papersize=A4 -V documentclass=report -V classoption=twocolumn -V geometry:"top=1.5cm, bottom=2.5cm, left=1cm, right=1cm" --toc --toc-depth=3 --number-sections --top-level-division=chapter -o "! - Machine Learning.pdf" *.txt *.md
