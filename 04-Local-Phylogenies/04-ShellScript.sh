
# /home/asommer3/Research/stablefly_wgs
# Note that any FastTree computation was done on a seperate server and has different file structure. 


####04.1 E. coli Pangenome and Core Genome Alignment
mkdir /home/asommer3/Research/stablefly_wgsanalysis/panaroo/Escherichia
panaroo -i /home/asommer3/Research/stablefly_wgsdata/GFF_organized/Escherichia/*.gff -o /home/asommer3/Research/stablefly_wgsanalysis/panaroo/Escherichia --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8


####04.2 KP1 local Pangenome and Core Genome Alignment
mkdir /home/asommer3/Research/stablefly_wgsanalysis/panaroo/Klebsiella
panaroo -i /home/asommer3/Research/stablefly_wgsdata/GFF_organized/Klebsiella/*.gff -o /home/asommer3/Research/stablefly_wgsanalysis/panaroo/Klebsiella --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8


####04.3 FastTree for Phylogenetic Analysis.
# The core_gene_alignment_filtered are produced by the respective panaroo analysis
/FastTree -nt -log logfile.txt  core_gene_alignment_filtered.aln > escherichia_core_gene_tree.newick
/FastTree -nt -log logfile.txt  core_gene_alignment_filtered.aln > KP_core_gene_tree.newick