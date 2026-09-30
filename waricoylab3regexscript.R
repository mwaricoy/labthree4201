data <- readLines("messy_sequences.fasta")

headers <- data[substr(data, 1, 1) == ">"]
headers <- sub("^>", "", headers)

sample_id <- sub("\\|.*", "", headers)

gene <- sub(".*(BRCA1|TP53|EGFR).*", "\\1", headers)

organism <- rep("Homo_sapiens", length(headers))

lasttable <- data.frame(sample_id, organism, gene)

lasttable

