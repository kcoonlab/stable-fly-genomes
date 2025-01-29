
# /home/asommer3/Research/stablefly_wgs
#all  contigs/assemblies were organized/moved based on taxonmy to /contigs_organized/FOLDER


####03.1 ClermonTyping for e coli phylogroups. See: (https://github.com/A-BN/ClermonTyping)
mkdir /home/asommer3/Research/stablefly_wgs/analysis
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ClermonTyping
cd  /home/asommer3/Research/stablefly_wgs/analysis/ClermonTyping
chmod +x ClermonTyping/clermonTyping.sh 
chmod +x ./ClermonTyping/bin/clermont.py
chmod +x ./ClermonTyping/bin/mash
#fastafilepath is a list to all the fasta files
./ClermonTyping/clermonTyping.sh --fastafile fastafilepath.txt
find ./analysis_2024-06-06_113430 -type f -name "*.fa" -exec rm {} +
find ./analysis_2024-06-06_113430 -type f -name "*.fa.xml" -exec rm {} +

####03.2 Kleborate for Klebsiella pneumoniae 
mkdir /home/asommer3/Research/stablefly_wgs/analysis/kleborate
kleborate --all -o /home/asommer3/Research/stablefly_wgs/analysis/kleborate/results.txt -a  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Klebsiella_P/*.fa


####03.3 MLST 
conda activate mlst
mkdir /home/asommer3/Research/stablefly_wgs/analysis/mlst
mlst --scheme klebsiella /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Klebsiella_P/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/mlst/klebsiella_mlst.csv
mlst --scheme ecoli /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Escherichia/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/mlst/ecoli_mlst.csv
conda deactivate

####03.4 Abricate for VF/ARGs 
conda activate abricate

# E. coli VirulenceFinder
mkdir /home/asommer3/Research/stablefly_wgs/analysis/VFs
mkdir /home/asommer3/Research/stablefly_wgs/analysis/VFs/Escherichia
abricate --db virulencefinder /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Escherichia/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/VFs/Escherichia/Escherichia_virulencefinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/VFs/Escherichia/Escherichia_virulencefinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/VFs/Escherichia/Escherichia_virulencefinder_summary.tab

#vfdb for all
mkdir /home/asommer3/Research/stablefly_wgs/analysis/VFs/All
abricate --db vfdb ../results/shovill_assembled_contigs/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/VFs/All/All_vfdb_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/VFs/All/All_vfdb_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/VFs/All/All_vfdb_summary.tab

#Resfinder for all 
mkdir /home/asommer3/Research/stablefly_wgs/analysis/Resfinder
mkdir /home/asommer3/Research/stablefly_wgs/analysis/Resfinder/All
abricate --db resfinder ../results/shovill_assembled_contigs/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/Resfinder/All/All_Resfinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/Resfinder/All/All_Resfinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/Resfinder/All/All_Resfinder_summary.tab

#PlasmidFinder for all 
mkdir /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder

abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Escherichia/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Escherichia_plasmidfinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Escherichia_plasmidfinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Escherichia_PlasmidFinder_summary.tab

abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Klebsiella_P/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Klebsiella_P_plasmidfinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Klebsiella_P_plasmidfinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Klebsiella_P_PlasmidFinder_summary.tab

abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Acinetobacter/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Acinetobacter_plasmidfinder_results.tab #0 hits
abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Bacillus/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Bacillus_plasmidfinder_results.tab #0 hits

abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Enterobacter/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Enterobacter_plasmidfinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Enterobacter_plasmidfinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Enterobacter_PlasmidFinder_summary.tab

abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/data/contigs organized/Other_Enteros/*.fa > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Other_Enteros_plasmidfinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Other_Enteros_plasmidfinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Other_Enteros_PlasmidFinder_summary.tab

find /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph -name '*.fa' -print0 | xargs -0 abricate --db plasmidfinder > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Staph_plasmidfinder_results.tab
abricate --summary /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Staph_plasmidfinder_results.tab > /home/asommer3/Research/stablefly_wgs/analysis/PlasmidFinder/Staph_PlasmidFinder_summary.tab

conda deactivate

