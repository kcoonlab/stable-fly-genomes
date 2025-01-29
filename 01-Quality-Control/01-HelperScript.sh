
#sample_list.txt can be changed as needed, but has each sample name (ex: AS0203) on a seperate line with LF line endings
#Save each as a seperate file below to run (or copy and paste full loop into the terminal)

###run_fastqc_raw.sh
for sample in $(cat sample_list.txt)
do
	fastqc /home/asommer3/Research/stablefly_wgs/data/raw_sequences/"$sample"*.fastq.gz --outdir /home/asommer3/Research/stablefly_wgs/results/raw_fastqc_results
done
#END run_fastqc_raw.sh

####trimming_script.sh
mkdir /home/asommer3/Research/stablefly_wgs/data/paired_trimmed_reads
mkdir /home/asommer3/Research/stablefly_wgs/data/unpaired_trimmed_reads

cd ./Trimmomatic-0.39
echo "trimming"
    for sample in $(cat ../sample_list.txt)
        do
	    java -jar trimmomatic-0.39.jar PE \
        /home/asommer3/Research/stablefly_wgs/data/raw_sequences/"$sample"*R1_001.fastq.gz \
        /home/asommer3/Research/stablefly_wgs/data/raw_sequences/"$sample"*R2_001.fastq.gz \
        /home/asommer3/Research/stablefly_wgs/data/paired_trimmed_reads/"$sample"_R1_trimmed.fq.gz \
        /home/asommer3/Research/stablefly_wgs/data/unpaired_trimmed_reads/"$sample"_R1_trimmed_unpaired.fq.gz \
        /home/asommer3/Research/stablefly_wgs/data/paired_trimmed_reads/"$sample"_R2_trimmed.fq.gz \
        /home/asommer3/Research/stablefly_wgs/data/unpaired_trimmed_reads/"$sample"_R2_trimmed_unpaired.fq.gz \
        ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36
    done
 echo "done"
#END trimming_script.sh


###run_fastqc.sh
for sample in $(cat sample_list.txt)
do
	fastqc /home/asommer3/Research/stablefly_wgs/data/fastq/"$sample"*.fastq.gz --outdir /home/asommer3/Research/stablefly_wgs/results/fastqc_results
done
#END run_fastqc.sh
