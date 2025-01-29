#This script provides how eggnogmapper was used for functional annnotation of the strains (M. sciuri). For the statistical analysis, please see the R script section

####05.1 eggNOG-mapper setup
find/home/asommer3/Research/stablefly_wgs/results/prokka_annotations -name '*.faa' -exec cp {} ../data/faa \; #copy the M. sciuri genomes seqenced in this study
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/faa
find /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations -name '*.faa' -exec cp {} /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/faa \; #copy the M. sciuri genomes downloaded from NCBI

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/emapper
cd /home/asommer3/Research/stablefly_wgs/working/emapper
export EGGNOG_DATA_DIR=/home/asommer3/eggnog-mapper-data
sh run_emapper_NCBI_sciuri.sh



####05.1 eggNOG-mapper run
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/faa"
output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/emapper"
for input_file in "$input_dir"/*.faa
do
    base_name=$(basename "$input_file" .faa)
    emapper.py -m diamond --cpu 8 --itype proteins -i "$input_file" -o "$base_name" --output_dir "$output_dir"
done

