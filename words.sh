#!/bin/bash
# words.sh -- extract words and periods from text
# this code is part of bash-textgen: https://github.com/massimo-nazaria/bash-textgen
# usage: cat [text file] | ./words.sh > [word file]
# text trasformations performed:
# - make all input text lowercase
# - remove non-alphabetical characters except for the periods
# - remove multiple whitespaces and period characters
# - output one word (or period) per line
cat /dev/stdin\
	| tr 'A-Z' 'a-z'\
	| sed 's/[^a-z.]/ /g'\
	| tr -s ' .'\
	| sed 's/\./ \. /g'\
	| tr -s ' '\
	| tr ' ' '\n'\
	| grep -v '^$';
exit 0;
