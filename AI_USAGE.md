# Part One: AI Code Solution

##  Prompt: Using this FASTA file in my desktop I want you to write a code and give me a table in the chat to sort each sample (8 total) by, sample id, organism and gene. The file is messy as named so the other headers need to be cut off. 

```
library(stringr)

lines <- readLines("~/Desktop/messy_sequences.fasta")
```
### Find where each FASTA header occurs
```
header_pos <- which(str_detect(lines, "^>"))
```
### Extract headers
```
headers <- lines[header_pos]

# Extract sequences between headers
sequences <- sapply(seq_along(header_pos), function(i) {
  start <- header_pos[i] + 1
  end <- if (i < length(header_pos)) header_pos[i + 1] - 1 else length(lines)
  paste(lines[start:end], collapse = "")
})
```
### Remove >
```
headers <- str_remove(headers, "^>")
```
### Extract fields
```
sample_id <- str_extract(headers, "^[^ |;]+")

organism <- str_extract(
  headers,
  "Homo_sapiens|Homo sapiens|H\\.sapiens|Hsapiens"
)

organism[!is.na(organism)] <- "Homo sapiens"

gene <- str_extract(
  headers,
  "BRCA1|TP53|EGFR|KRAS|PTEN|HLA-DRB1"
)

length_bp <- str_extract(
  headers,
  "\\d+(?=\\s*bp)|(?<=len[=:])\\d+|(?<=length[=:])\\d+"
)

length_bp <- as.numeric(length_bp)
```
### Create table
```
result <- data.frame(
  sample_id,
  organism,
  gene,
  length_bp,
  sequence = sequences
)

print(result)
```

#Part Two: AI Assistance in my Code

## Model

For this lab I used Microsoft Co-Pilot.

## Sample ID

But then I got to my sample ID in which I was researching on the proper way to format the code but I kept getting this error:
```
 unexpected '>' in ">"
```
And so I copied and pasted this error into AI. And it explained that R was "complaining" because I was putting the > symbol in my code before any other syntax, which I wasn't. So I copied and pasted the regex code assignment I was trying to do:
```
> sample_id <- sub(".*_", "", headers)
```
And it told me to restart R which fixed the error message, which was bothering me for a long time.

## Gene

I decided to assign the variable gene with all of the genes I know are in the file and let the regex figure out which is which, but when I tested the code in the console, I kept getting this return now:
```
[1] "" "" "" "" "" "" "" ""
```
So I copied and pasted that return into AI, and it told me that I was removing the gene values instead of extracting them in my code because my x value was "", which I checked and it was:
```
 gene <- sub(".*(BRCA1|TP53|EGFR).*", "", headers)
```
So I copied and pasted that code and asked what to replace it with so I wouldn't get quotation marks, and it said to use this:
```
gene <- sub(".*(BRCA1|TP53|EGFR).*", "\\1", headers)
```
Which worked!

## Getting the right headers

This is the return I was getting when I inputted my table. I not a system error, but this same result that I did not want because there were no values on the table:
```
[1] sample_id organism  gene     
<0 rows> (or 0-length row.names)
```
So I plugged this exact return into my AI and asked what was going wrong. It said that the parsing wasn't getting any values from the headers initally, so all of the values came out as 0. So I copied and pasted my headers assigning code into the AI:
```
headers <- data[substr(data, 1, 8) == ">"]
headers <- substring(headers, 2)
```
And it told me to change the 8, to a 1 because I was returning an empty vector. So I checked it to confirm, and then change it and the error went away.

## Wrong Sample ID

This is the return I was getting when I inputted my table:
```
lasttable
                                  sample_id     organism  gene
1                sapiens|gene=BRCA1|len=120 Homo_sapiens BRCA1
2 Sample002 organism:Homo sapiens gene:TP53 Homo_sapiens  TP53
3             sapiens | EGFR | length=150bp Homo_sapiens  EGFR
4        004;species=H.sapiens;target=BRCA1 Homo_sapiens BRCA1
5      sample005 Homo sapiens; TP53; 130 bp Homo_sapiens  TP53
6                        seq6|Hsapiens|EGFR Homo_sapiens  EGFR
7      sapiens|gene=BRCA1|note:re-sequenced Homo_sapiens BRCA1
8                  sapiens gene:TP53 len:NA Homo_sapiens  TP53
```

Which is not what I wanted for the table, so I inputted my return to the AI, and it said that the regex was too "greedy" by extracting everything in the header column and I needed to change my code by grabbing everything up to the first deliminator like a space or semicolon or something. So it told me to use this:

```
sample_id <- sub("^([^ ;|]+).*", "\\1", headers)
```
Which I tried and it solved the issue and it returned my final table.
