
# /home/asommer3/Research/stablefly_wgs


####02.1 Shovill Genome Assembly
conda activate Shovil
mkdir /home/asommer3/Research/stablefly_wgs/results
mkdir /home/asommer3/Research/stablefly_wgs/results/shovill_assemblies
mkdir /home/asommer3/Research/stablefly_wgs/results/shovill_assembled_contigs

sh run_shovill.sh #Shovill genome assembler using SPades
sh rename_shovill.sh #I did not like the file names for some reason
#find /home/asommer3/Research/stablefly_wgs/results/shovill_assemblies -name '*_contigs.fa' -exec cp {} /home/asommer3/Research/stablefly_wgs/results/shovill_assembled_contigs \; #to move the contigs.fa files into a seperate folder
conda deactivate

####02.2 Quast
mkdir /home/asommer3/Research/stablefly_wgs/results/quast_reports
sh run_quast.sh
cat /home/asommer3/Research/stablefly_wgs/results/quast_reports/*/transposed_report.tsv > /home/asommer3/Research/stablefly_wgs/results/quast_reports/combined_transposed_report.tsv

####02.3 Busco
conda activate busco
mkdir /home/asommer3/Research/stablefly_wgs/results/busco_assembly_QC
mkdir /home/asommer3/Research/stablefly_wgs/results/busco_summaries
sh run_busco.sh
cp /home/asommer3/Research/stablefly_wgs/results/busco_assembly_QC/*/*.txt /home/asommer3/Research/stablefly_wgs/results/busco_summaries
conda deactivate

####02.4 Prokka
conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/results/prokka_annotations

for sample in $(cat sample_list.txt)
do
	prokka \
    --outdir /home/asommer3/Research/stablefly_wgs/results/prokka_annotations"$sample"_prokka \
    --prefix "$sample" \
    --rfam \
    /home/asommer3/Research/stablefly_wgs/results/shovill_assembled_contigs/"$sample"_contigs.fa
done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/data/ProkkaGFF
find /home/asommer3/Research/stablefly_wgs/results/prokka_annotations -name '*.gff' -exec cp {} /home/asommer3/Research/stablefly_wgs/data/ProkkaGFF \;



