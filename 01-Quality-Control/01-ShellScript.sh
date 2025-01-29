#####The initial quality control for samples sequenced at UW-Madison Biotech Center and SeqCoast Genomics. SeqCoast Genomics samples were provided with trimmed reads; I did trimming on the Biotech Center genomes
#Scripts kept in folder ../script
cd /path/to/directory/stablefly_wgs

mkdir /path/to/directory/stablefly_wgs/data
mkdir /path/to/directory/stablefly_wgs/results
mkdir /path/to/directory/stablefly_wgs/working
mkdir /path/to/directory/stablefly_wgs/script
###for me /path/to/directory/ is /home/asommer3/Research/


####01.1 Run FastQC on the raw biotech center samples
conda activate fastqc-env
mkdir /home/asommer3/Research/stablefly_wgs/results/raw_fastqc_results
sh /home/asommer3/Research/stablefly_wgs/script/run_fastqc_raw.sh #output in /results/raw_fastqc_results
conda deactivate

####01.2 Run Multiqc on the raw biotech center samples
conda activate multiqc-env
mkdir /home/asommer3/Research/stablefly_wgs/results/raw_multiqc
multiqc /home/asommer3/Research/stablefly_wgs/results/raw_fastqc_results -o /home/asommer3/Research/stablefly_wgs/results/raw_multiqc
conda deactivate

#####01.3 Trimming Adaptors  via Trimmomatic-0.39
cd /home/asommer3/Research/stablefly_wgs/working
wget https://github.com/usadellab/Trimmomatic/files/5854859/Trimmomatic-0.39.zip
unzip Trimmomatic-0.39.zip
cd ./Trimmomatic-0.39
find . -mindepth 2 -type f -print -exec mv {} . \;
cd ../
sh /home/asommer3/Research/stablefly_wgs/script/trimming_script.sh

#####01.4 Run FastQC on all samples 
#Add all of the raw sequences to a folder "seqcoast_sequences". Seqcoast names are as follows: "4939_107_S27_R1_001.fastq.gz"... you will need to change it to add the strain name at the beginning according to the sample manifest
#At this point, we can analyze all the genomes together. The sample_list.txt should have all of the strain names/ID
#For below code, you can put all the trimmed reads in a folder called  /path/to/directory/stablefly_wgs/data/fastq
conda activate fastqc
mkdir /home/asommer3/Research/stablefly_wgs/results/fastqc_results
sh /home/asommer3/Research/stablefly_wgs/script/run_fastqc.sh #output in stablefly_wgs/results/fastqc_results
conda deactivate

#####01.5 Run Multiqc on all samples 
conda activate multiqc
mkdir /home/asommer3/Research/stablefly_wgs/results/multiqc
multiqc /home/asommer3/Research/stablefly_wgs/results/fastqc_results -o /home/asommer3/Research/stablefly_wgs/results/multiqc
conda deactivate
