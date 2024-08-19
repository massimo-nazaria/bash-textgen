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

# make temporary dir in /tmp
tmpd=`mktemp -d`;

# redirect words from stdin to a temporary file named 1-grams in the /tmp folder
cat - > ${tmpd}/1-grams;

# start building n-grams one step at a time starting from 2-grams
for i in `seq 2 $n`; do
	# compute temporary file with (i)-grams in the /tmp folder
	paste -d' ' <(head -n -1 ${tmpd}/$(($i-1))-grams) <(tail -n +$i ${tmpd}/1-grams) > ${tmpd}/${i}-grams
done

# output last temporary generated n-gram file
cat ${tmpd}/${n}-grams;

# clean up temporary dir
rm -rf $tmpd;

# terminate program successfully
exit 0;
