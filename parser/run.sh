#!/bin/bash

rm lex.yy.c teste05.tab.* teste05


flex teste05.l

bison -d teste05.y

gcc -o teste05 lex.yy.c teste05.tab.c -Wall -ll
