# Lab Three PUBH4201

## Comparing Outputs

I gave the AI this prompt to compare with my regex code results: 

" Using this FASTA file in my desktop I want you to write a code and give me a table in the chat to sort each sample (8 total) by, sample id, organism and gene. The file is messy as named so the other headers need to be cut off."

This was the output for my code: 

```
  sample_id     organism  gene
1 sample_001 Homo_sapiens BRCA1
2  Sample002 Homo_sapiens  TP53
3 sample-003 Homo_sapiens  EGFR
4 SAMPLE_004 Homo_sapiens BRCA1
5  sample005 Homo_sapiens  TP53
6       seq6 Homo_sapiens  EGFR
7 Sample_007 Homo_sapiens BRCA1
8   sample-8 Homo_sapiens  TP53
```
This was the output from the AI 
```
sample_id     organism  gene length_bp
1 sample_001 Homo sapiens BRCA1       120
2  Sample002 Homo sapiens  TP53        NA
3 sample-003 Homo sapiens  EGFR       150
4 SAMPLE_004 Homo sapiens BRCA1        NA
5  sample005 Homo sapiens  TP53       130
6       seq6 Homo sapiens  EGFR        NA
7 Sample_007 Homo sapiens BRCA1        NA
8   sample-8 Homo sapiens  TP53        NA
                                                                                                                                                       sequence
1                                      CTAAAGACAATTACATAACATACACGTCAGCACGAAACTTGTTGGCCCAGTGTGAATCGCTTAAGGGTTAAGTAAGTGTGATGCATACGCCTTTACTTGCTGTGTCCACCCCATCGGACT
2                        GGCATTTTTATTACACTCAGAAACAGAACTCGGGTAATTTTGACAGGTCACGCAGAGGCGCGCCCTCCTGAAGTGCGTGGACACTCGCTATGAATCTCTGATTTACCCACTCTGCCAAACTCCAGCGCGGTCAG
3 TTCCATCACCCTAAGTAACCGAATAATGCGTTCGCTCTATTGACTACGACGCGCTCATTCCCTTGTCGGAGAGTTATGGAACAAGGACGCTGTCTGAGACTAGAAGACAGATAGTGCACACGACCGGCGTCGGAGAAACTCTATTTGCCGCCTGACA
4                                                      GTCAATGCGATCCGTAGGGGCAGCGCAGTATGCCAAGACTATAGGCACTGTCGCATCACAAACGATTAACTGATAAATGAGCCCTTTATGACACGGGCATATGA
5              CTGGTTTACGATAGTATGTCCAACGGCGAGCTTTACATTTGCTGTGAGAGGTACAGGGATTAGTGAGAAGCCGTGCGTATCAATTCGTACCTTGGGGGTCGTTACCACTCTGTTCCCACGAGCGGCATTTCTGGATGGCCAGCT
6                                 TTGACATTTAATTTCACCCATAAACCAGCGTAAAGCTGCAAGTGGCTCCATGAACTTAGCTGCTAGTGTCAGACTCGCCTCGGATCCTTACTACACTAACTTGAACGCCTAGTGGTCAAAGAGTA
7                       CTGGTAATCGTCGGTATCTATATAAGCAGGGGAGGGGAAACATTTGTTCTCAGCCGGTGACTCCTAATGCTAAGACATTTCCCTTCAGGGGGGGCTCCCCCGCGATGCCATAAATCTGAGCAACCAGCTGAAGCA
8                                   GCACGACAGTGCGACATTATATCACTGTGGTAGGTTAGCTTCATCTAATGTCCAACTAGCCGGCCAATTCGCATGATACCTCTCCATCTGACCCAAGATTGTGCTTGTTCAATTCTTCTTAAC
```

### Where did they agree/disagree?
As you can see, although the sample ID, organism, and gene columns agreed with eachother, the AI also kept the length of the base pairs within the table. The AI also added a another column for the gene sequences which is not what I instructed it to do. 
### Which caught edge cases the other missed?


### Time/effort comparison: which was faster to get right?
Although I only tried the AI solution once, I am sure if I told it again to leave out the base pair and sequence columns, it would give me the right table. My efforts would have taken muc longer than the AI to get to the same results. 

## Identify Failure Modes

### 1. Sample 2,4, 6, and 7 Length BP Values
In the AI solution, not only was the AI not supposed to use base pair length, but it also added NA to the column when that sample has no reference to base pair length in the samples' headers within the FASTA file. Instead of putting nothing, it put NA by mistake probably because  sample 8 has NA for it's base pair length. 

### 2. Organism name
In the AI solution and my resulting table, the code switched the organism names in samples. Although I did mine on purpose, the AI solution switched them all to "Homo sapiens" when in reality a lot of the organism names in the FASTA file were named "Homo_sapiens," "H.sapiens," and "Hsapiens." The AI might have done this because just "Homo sapiens" is a bit of a cleaner name.
