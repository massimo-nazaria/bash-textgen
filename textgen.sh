#!/bin/bash
# textgen.sh -- generate random text from n-grams and initial words
# this code is part of bash-textgen: https://github.com/massimo-nazaria/bash-textgen
# usage: ./textgen.sh [ngram file] [initial n-1 words]
# note: [ngram file] must be made with ngrams.sh

# if wrong number of arguments, print usage and terminate
if [ $# -ne 2 ]; then
	echo "usage: $0 [ngram file] [initial n-1 words]" >> /dev/stderr;
	exit -1;
# if ngram file does not exist, print error and terminate
elif [ ! -f $1 ]; then
	echo "ngram file $1 does not exist" >> /dev/stderr;
	exit -1;
fi

# given ngram file
ngrams="$1";
# compute n from ngram file
n=$(cat "$ngrams" | head -n 1 | wc -w);
# make array with given initial words all lowercase (like the ngrams)
init=($(echo "$2" | tr 'A-Z' 'a-z'));

# if wrong number of initial words, print error and terminate
if [ ${#init[@]} -ne $(($n-1)) ]; then
	echo "initial words must be $(($n-1)) for ngrams with n=$n" >> /dev/stderr;
	exit -1;
fi

# print initial words (no newline)
echo -n "${init[*]}";
# initialize array with previous n-1 words
prev=${init[@]};
# start (hopefully not) infinite loop
while true; do
	# randomly extract next word from a line (in ngrams) that begins with previous n-1 words
	next="`cat "${ngrams}" | grep -e "^${prev[*]} " | shuf | head -n 1 | cut -d ' ' -f$n`";
	# exit loop if either no next word exists or next word is a period
	if [[ -z "${next}" || "${next}" == "." ]]; then
		break;
	fi
	# print current next word (no newline)
	echo -n " ${next}";
	# re-assign previous n-1 words including current next word
	prev=(${prev[@]:1:$(($n-1))} ${next});
done

# print period and terminate the program
echo ".";
exit 0;
