
#sample_list.txt can be changed as needed, but has each sample name (ex: AS0203) on a seperate line with LF line endings
#Save each as a seperate file below to run (or copy and paste full loop into the terminal)
#The two sequencing companies had different naming systems and processed at different times. The naming system here is in regard to SeqCoast samples

###run_shovill.sh
raw_sequences_dir="/home/asommer3/Research/stablefly_wgs/data/fastq" #paired reads
shovill_output_dir="/home/asommer3/Research/stablefly_wgs/results/shovill_assemblies"
contigs_output_dir="/home/asommer3/Research/stablefly_wgs/results/shovill_assembled_contigs"

# Read the sample list and process each sample
for sample in $(cat sample_list.txt)
do
    # Define input file paths. Change as needed 
    R1_file="${raw_sequences_dir}/${sample}"*_R1_001.fastq.gz
    R2_file="${raw_sequences_dir}/${sample}"*_R2_001.fastq.gz

    # Run shovill
    shovill \
        --R1 $R1_file \
        --R2 $R2_file \
        --outdir "${shovill_output_dir}/shovill_${sample}"
#END run_shovill.sh

###rename_shovill.sh
cd /home/asommer3/Research/stablefly_wgs/results/shovill_assemblies

for dir in shovill_AS*; do
    # Extract the sample name (AS____) from the directory name
    sample_name=$(echo $dir | cut -d'_' -f2)

    # Change to the current directory
    cd $dir

    # Rename the files with the sample name prefix
    mv contigs.fa ${sample_name}_contigs.fa
    mv contigs.gfa ${sample_name}_contigs.gfa
    mv shovill.corrections ${sample_name}_shovill.corrections
    mv shovill.log ${sample_name}_shovill.log
    mv spades.fasta ${sample_name}_spades.fasta

    # Go back to the parent directory
    cd ..
done
#END rename_shovill.sh


###run_quast.sh
raw_sequences_dir="/home/asommer3/Research/stablefly_wgs/data/fastq"
contigs_dir="/home/asommer3/Research/stablefly_wgs/results/shovill_assembled_contigs"
quast_output_dir="/home/asommer3/Research/stablefly_wgs/results/quast_reports"

for sample in $(cat sample_list.txt)
do
    # Define input file paths
    R1_file="${raw_sequences_dir}/${sample}_*_R1_001.fastq.gz"
    R2_file="${raw_sequences_dir}/${sample}_*_R2_001.fastq.gz"
    contigs_file="${contigs_dir}/${sample}_contigs.fa"

    # Run QUAST
    quast.py \
        -o "${quast_output_dir}/quast_${sample}" \
        --gene-finding \
        --threads 8 \
        --pe1 $R1_file \
        --pe2 $R2_file \
        $contigs_file
done
#End run_quast.sh




###run_busco.sh
for sample in $(cat sample_list.txt)
do
	busco \
    -i /home/asommer3/Research/stablefly_wgs/results/shovill_assembled_contigs/"$sample"_contigs.fa \
    -l bacteria_odb10 \
    -m genome \
    -o /home/asommer3/Research/stablefly_wgs/results/busco_assembly_QC/"$sample"_spades_busco

done
#End run_busco.sh


for sample in $(cat sample_list.txt)
do
	prokka \
    --outdir ../results/prokka_annotations/"$sample"_prokka \
    --prefix "$sample" \
    --rfam \
    ../results/shovill_assembled_contigs/"$sample"_contigs.fa


done