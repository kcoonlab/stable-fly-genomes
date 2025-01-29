
# /home/asommer3/Research/stablefly_wgs
# Note that any FastTree computation was done on a seperate server and has different file structure. 
# The dRep/FastANI comparison was used to remove closely related strains from the same BioProject. 
# CheckM was used to screen NCBI genomes for quality
# Trees were created using /FastTree -nt using the core-filtered alignment from panaroo (see 04-ShellScript for example)

####05.1 Construction of E. coli phylogeny
conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile Ecoli_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done


#ClermonTyping of NCBI Strains
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ClermonTyping
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ClermonTyping
ls /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ncbi_dataset/fna/*.fna > NCBI_Ecoli_files.txt
/home/asommer3/Research/stablefly_wgs/analysis/ClermonTyping/ClermonTyping/clermonTyping.sh --fastafile NCBI_Ecoli_files.txt
find ./analysis_2024-08-05_105208 -type f -name "*.fna" -exec rm {} +
find ./analysis_2024-08-05_105208 -type f -name "*.fna.xml" -exec rm {} +


conda activate checkm
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/checkm
checkm taxonomy_wf genus Escherichia -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/checkm/checkm.tsv
conda deactivate

cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999


conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/Ecoli/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8




####05.2 Construction of KPI phylogeny
conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1 #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile KP1_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

conda activate checkm
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/checkm
checkm taxonomy_wf genus Klebsiella -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/checkm/checkm.tsv
conda deactivate

cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999


conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;


mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/KP1/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8




####05.3 Construction of M. sciuri phylogeny 
conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile sciuri_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

conda activate checkm
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/checkm
checkm taxonomy_wf family Staphylococcaceae -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/checkm/checkm.tsv
conda deactivate

cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999


conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;


mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/sciuri/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8




####05.4 Construction of S. shinii phylogeny 

conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile shinii_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/checkm
checkm taxonomy_wf genus Staphylococcus -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/checkm/checkm.tsv
#Delete other output files than the summary due to Space
conda deactivate

cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999


conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;


mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/shinii/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8


####05.5 Construction of S. xylosus phylogeny 
conda activate ncbi_datasets
cd ./Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus #then added a file list of ncbi genomes to download

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus
datasets download genome accession --inputfile xylosus_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

conda activate checkm # checkm taxon_list
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/checkm
checkm taxonomy_wf genus Staphylococcus -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/checkm/checkm.tsv
#Delete other output files than the summary due to Space. Remove low quality assemblies
conda deactivate



cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/drep_strain

dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999


conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations/output
#input dir is /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/ncbi_dataset/fna
#output dir is /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/xylosus/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8


####05.6 Construction of S. arlettae phylogeny 
conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile arlettae_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

conda activate checkm
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/checkm
checkm taxonomy_wf genus Staphylococcus -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/checkm/checkm.tsv
conda deactivate


cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999


conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/arlettae/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8


####05.7 Construction of S. gallinarum phylogeny 

conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile gallinarum_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

conda activate checkm
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/checkm
checkm taxonomy_wf genus Staphylococcus -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/checkm/checkm.tsv
conda deactivate


cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999

conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;


mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/gallinarum/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8


####05.8 Construction of S. pseudoxylosus phylogeny 
conda activate ncbi_datasets
cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus

cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus #then added a file list of ncbi genomes to download

datasets download genome accession --inputfile pseudoxylosus_GCA.txt --include genome
unzip ncbi_dataset.zip
rm ncbi_dataset.zip
conda deactivate

cd ./ncbi_dataset
mkdir fna; for f in data/*/*.fna; do
   out=$( echo $f | cut -f2 -d'/');
   mv $f fna/${out}.fna;
done

conda activate checkm
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/checkm
checkm taxonomy_wf genus Staphylococcus -t 8 -x fna /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/ncbi_dataset/fna  /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/checkm --file /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/checkm/checkm.tsv
conda deactivate


cd /home/asommer3/Research/stablefly_wgs/working
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/drep_highlyrelated
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/drep_highlyrelatedconserved
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/drep_strain
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/drep_highlyrelated -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/ncbi_dataset/fna/*.fna --P_ani .998  --S_ani .998
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/drep_highlyrelatedconserved -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/ncbi_dataset/fna/*.fna --P_ani .999  --S_ani .999
dRep compare /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/drep_strain -g /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/ncbi_dataset/fna/*.fna --P_ani .9999  --S_ani .9999

conda activate prokka
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/prokka_annotations
mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/prokka_annotations/output
input_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/ncbi_dataset/fna"; output_dir="/home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/prokka_annotations/output"; cd "$input_dir"; for file in *.fna; do tag=${file%.fna}; prokka --prefix "$tag" --locustag "$tag" --outdir "$output_dir/2017-06-12_${tag}_prokka" --force --addgenes --gcode 11 "$file"; done
conda deactivate

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/prokka_annotations/gff_prokka
cd /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/prokka_annotations/output
find . -name '*.gff' -exec cp {} ../gff_prokka \;

mkdir /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/panaroo
cd /home/asommer3/Research/stablefly_wgs/working
panaroo -i /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/prokka_annotations/gff_prokka/*.gff -o /home/asommer3/Research/stablefly_wgs/analysis/ncbi/pseudoxylosus/panaroo --clean-mode strict -a core --aligner mafft --core_threshold 0.98 -t 8
