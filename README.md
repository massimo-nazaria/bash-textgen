# BASH-TEXTGEN -- Text Generation in Bash

A Bash toolchain to generate random text that resembles the input text corpus by using n-grams.

More info: [Natural Language Processing in Bash](https://massimo-nazaria.github.io/nlp.html).

## QUICK START

Let's generate some prose by training our model using [_Moby-Dick_](https://gutenberg.org/ebooks/15) as text corpus.

### 1. Get the `bash-textgen/` folder and enter it

```sh
$ git clone https://github.com/massimo-nazaria/bash-textgen.git
$ cd bash-textgen/
```

### 2. Make the Bash scripts executable

```sh
$ chmod +x *.sh
```

### 3. Extract words

```sh
$ cat moby-dick.txt | ./words.sh > words.txt
```

### 4. Make trigrams

```sh
$ cat words.txt | ./ngrams.sh 3 > trigrams.txt
```

### 5. Generate a sentence

```sh
$ ./textgen.sh trigrams.txt "a man"
```

#### _Output_

> a man gives himself out of this blubbering now we are about to begin from the hearts of whales is always under great and extraordinary difficulties that every one knows the fine carnation of their yet suspended boats.

## TOOLCHAIN USAGE

### words.sh -- extract words and periods from text

```sh
cat [text file] | ./words.sh > [word file]
```

_Text trasformations_:

1. Make all input text lowercase;
2. Remove non-alphabetical characters except for the periods `.`;
3. Remove multiple whitespaces and period characters;
4. Output one word (or period) per line.

### ngrams.sh -- compute n-grams from words

```sh
cat [word file] | ./ngrams.sh [n] > [ngram file]
```

* [n] argument must be >= 2
* input [word file] must be made with `words.sh`
* output [ngram file] contains [n]-grams (one per line)

### textgen.sh -- generate random text from n-grams

```sh
./textgen.sh [ngram file] [initial n-1 words]
```

* [ngram file] argument must be made with `ngrams.sh`
* [initial words] argument must be a string with _n_-1 words, i.e. one word less than given _n_-grams
* the generated sentence in output starts with the provided initial _n_-1 words
