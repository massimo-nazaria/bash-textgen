#!/bin/bash
# ngrams.sh -- generate n-grams from input words
# this code is part of bash-textgen: https://github.com/massimo-nazaria/bash-textgen
# usage: cat [word file] | ./ngrams.sh [n] > [ngram file]
# note: [n] must be >= 2 and [word file] made with words.sh
# sample input:
# w1
# w2
# w3
# output bigrams (i.e. n=2):
# w1 w2
# w2 w3

# minimum allowed n
NMIN=2;
# if wrong arguments, print usage and terminate
if [ $# -ne 1 ] || [ ! $1 -ge $NMIN ]; then
	echo "usage: $0 [n] (with n >= ${NMIN})";
	exit -1;
fi

# provided n
n=$1;
# declare array to populate ngrams
declare -a ngram;
# compute n-1 once and for all
p=$(($n-1));
# populate ngram array with initial n words
for i in `seq 0 $p`; do
	read word;
	ngram[$i]=$word;
done
# print 1st ngram
echo ${ngram[*]};
# compute and print all the other ngrams
while read word; do
	# assign new ngram with previous ngram from 2nd word to end + new word
	ngram=(${ngram[@]:1:$p} $word);
	# print ngram
	echo ${ngram[*]};
done

exit 0;
