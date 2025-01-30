# stable-fly-genomes

### Overview
Comparative genomic analysis of bacterial strains isolated from *Stomoxys* (stable) flies and manure samples collected on a Wisconsin dairy farm. The repository contains code used for analysis of genomic read data and generation of associated figures.

### Availability of Sequence Data
Raw Illumina reads and assemblies are available in the NCBI Sequence Read Archive (https://www.ncbi.nlm.nih.gov/sra) under BioProject ID PRJNA1216036. 


### Folder Structure
**01** - FASTQ  file trimming and quality control (FastQC)\
**02** - Assembly (Shovill/SPAdes) and annotation (Prokka) along with associated quality control checks (Quast, BUSCO)\
**03** - Typing (Kleborate, ClermonTyping, MLST) and screening of contigs for VFs (vfdb/VirulenceFinder) and ARGs (Abricate)\
**04** - Core genome alignment and FastTree of sequenced *E. coli* and *K. pneumoniae* \
**05** - Selection of NCBI genome sets and associated phylogenetic tree construction\
**06** - Functional annotation (eggNOG-mapper) of *M. sciuri* \
**07** - Strain and ARG-encoding plasmid comparisons (Mummer4)\
**Figures** - Contain R Scripts, TreeViewer, and needed import files to recreate figures in the manuscript



### Contact 
Andrew J. Sommer - asommer3@wisc.edu\
Kerri L. Coon - kerri.coon@wisc.edu

