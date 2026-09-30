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

#Part Two: AI assistance in my code

