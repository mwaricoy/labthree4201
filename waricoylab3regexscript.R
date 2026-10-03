data <- readLines("~/Desktop/labthree4201/data/messy_sequences.fasta")

headers <- data[substr(data, 1, 1) == ">"]
headers <- substring(headers, 2)

sample_id <- sub("^([^ ;|]+).*", "\\1", headers)

organism <- rep("Homo_sapiens", length(headers))

gene <- sub(".*(BRCA1|TP53|EGFR).*", "\\1", headers)

lasttable <- data.frame(sample_id, organism, gene)

lasttable
write.csv(lasttable, "labthree4201fastatable.csv")
