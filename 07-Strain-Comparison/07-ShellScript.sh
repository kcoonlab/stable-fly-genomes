mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus



####07.1 KP1 Mummer4 comparisons.

#AS0363_vs_AS0560
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Klebsiella_P/AS0363_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Klebsiella_P/AS0560_contigs.fa

show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560_raw.coords
delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/KP/AS0363_vs_AS0560/AS0363_vs_AS0560.delta




####07.2 S. arlettae Mummer4 comparisons.

#AS0200_vs_AS0572
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/arlettae/AS0200_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/arlettae/AS0572_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0200_vs_AS0572/AS0200_vs_AS0572.delta


#AS0882_vs_AS0572
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/arlettae/AS0882_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/arlettae/AS0572_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0882_vs_AS0572/AS0882_vs_AS0572.delta


#AS0739_vs_AS0572
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/arlettae/AS0739_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/arlettae/AS0572_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/arlettae/AS0739_vs_AS0572/AS0739_vs_AS0572.delta


####07.3 S. xylosus Mummer4 comparisons.

#AS1331_vs_AS0569
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/xylosus/AS1331_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/xylosus/AS0569_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1331_vs_AS0569/AS1331_vs_AS0569.delta


#AS1347_vs_AS0569
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/xylosus/AS1347_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/xylosus/AS0569_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1347_vs_AS0569/AS1347_vs_AS0569.delta


#AS1293_vs_AS0569
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/xylosus/AS1293_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/xylosus/AS0569_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/xylosus/AS1293_vs_AS0569/AS1293_vs_AS0569.delta



####07.4 M. sciuri Mummer4 comparisons.

#AS0296_vs_AS0565
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS0296_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS0565_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.filtered.delta


dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.delta


mummerplot --filter --layout --png --no-gridlines --no-x-axis --no-y-axis  \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0296_vs_AS0565/AS0296_vs_AS0565.delta

#AS0650_vs_AS1395
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS0650_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS1395_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395.filtered.delta


dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0650_vs_AS1395/AS0650_vs_AS1395.delta



#AS0913_vs_AS0579
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS0913_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS0579_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579.filtered.delta


dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS0913_vs_AS0579/AS0913_vs_AS0579.delta

#AS1298_vs_AS0567
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS1298_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/Mammaliicoccus/sciuri/AS0567_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567.filtered.delta


dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/sciuri/AS1298_vs_AS0567/AS1298_vs_AS0567.delta



####07.5 S. gallinarum Mummer4 comparisons.

#AS0915_vs_AS0564
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0915_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0564_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0564/AS0915_vs_AS0564.delta

#AS0915_vs_AS0571
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0915_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0571_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0915_vs_AS0571/AS0915_vs_AS0571.delta

#AS1336_vs_AS0564
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS1336_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0564_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1336_vs_AS0564/AS1336_vs_AS0564.delta

#AS1286_vs_AS0564
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS1286_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0564_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1286_vs_AS0564/AS1286_vs_AS0564.delta

#AS0303_vs_AS0564
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0303_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0564_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS0303_vs_AS0564/AS0303_vs_AS0564.delta

#AS1328_vs_AS0564
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS1328_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0564_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1328_vs_AS0564/AS1328_vs_AS0564.delta

#AS1356_vs_AS0564
mkdir /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564
nucmer -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564 \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS1356_contigs.fa \
  /home/asommer3/Research/stablefly_wgs/data/contigs_organized/Staph/gallinarum/AS0564_contigs.fa
show-coords -r -c -l \
  /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564.delta \
  > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564_raw.coords

delta-filter -r -q /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564.delta > /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564.filtered.delta

dnadiff  \
  -p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564_dnadiff \
  -d /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564.delta

mummerplot --filter --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564_filtered \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564.delta

mummerplot --layout --png \
-p /home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564 \
/home/asommer3/Research/stablefly_wgs/analysis/MummerComparison/gallinarum/AS1356_vs_AS0564/AS1356_vs_AS0564.delta


####07.6 lnuA plasmid Mummer4/Mobmess comparison
#plasmid database was from 11-03-2023
#I want to start by trying all three small lnuA plasmids together: 13_4, 13_7, and 21_19
#Using references AM399082.1, AM399081.1

mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/input
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/mobmess
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/mars
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/plasmidfinder


#Added lnuA_replicons_preformatted.fasta to input subfolder. The fasta file has all rep proteins on (+) strand


cd /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/input
awk '/^>/ {if (NR>1) print ""; print $0; next} {printf "%s", $0} END {print ""}' lnuA_replicons_preformatted.fasta > lnuA_replicons_formatted.fasta 

conda activate abricate #abricate to doublecheck rep genes
abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/input/lnuA_replicons_formatted.fasta > /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/plasmidfinder/lnuA_plasmidfinder_results.tab
conda deactivate


####python####
python
input_file = '/home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/input/lnuA_replicons_formatted.fasta'
output_file = '/home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/mobmess/completeinfo.txt'

with open(input_file, 'r') as fasta_file, open(output_file, 'w') as output:
    for line in fasta_file:
        if line.startswith('>'):
            output.write(line[1:])  # Write header without '>'

#ctrl +z
#Then added in 1 next to each
########

conda activate mobmess #mobmess to calculate ANI between pairs
mobmess systems \
    --sequences /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/input/lnuA_replicons_formatted.fasta \
    --complete /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/mobmess/completeinfo.txt \
    --output /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/lnuA/mobmess/lnua-mobmess \
    --threads 8
conda deactivate

####07.6 tetK plasmid Mummer4/Mobmess comparison
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/input
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/mobmess
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/mars
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/plasmidfinder


#Added tetK_replicons_preformatted_noref.fasta to input subfolder. The fasta file has all rep proteins on (+) strand
conda activate abricate #abricate to doublecheck rep genes
abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/input/tetK_replicons_preformatted_noref.fasta > /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/plasmidfinder/tetK_plasmidfinder_results_nofref.tab
conda deactivate

#added refs to tetK_replicons_preformatted.fasta as reference. The accessions from the plasmid finder are actually not the closest sequences (checked via blast)


cd /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/input
awk '/^>/ {if (NR>1) print ""; print $0; next} {printf "%s", $0} END {print ""}' tetK_replicons_preformatted.fasta > tetK_replicons_formatted.fasta 



conda activate abricate #abricate to doublecheck rep genes
abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/input/tetK_replicons_formatted.fasta > /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/plasmidfinder/tetK_plasmidfinder_results.tab
conda deactivate



####python####
python
input_file = '/home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/input/tetK_replicons_formatted.fasta'
output_file = '/home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/mobmess/completeinfo.txt'

with open(input_file, 'r') as fasta_file, open(output_file, 'w') as output:
    for line in fasta_file:
        if line.startswith('>'):
            output.write(line[1:])  # Write header without '>'

#ctrl +z
#Then added in 1 next to each
########

conda activate mobmess #mobmess to calculate ANI between pairs
mobmess systems \
    --sequences /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/input/tetK_replicons_formatted.fasta \
    --complete /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/mobmess/completeinfo.txt \
    --output /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/tetK/mobmess/tetk-mobmess \
    --threads 8
conda deactivate

####07.7 str plasmid Mummer4/Mobmess comparison
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/input
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/mobmess
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/mars
mkdir /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/plasmidfinder


#Added str_replicons_preformatted_noref.fasta to input subfolder. The fasta file has all rep proteins on (+) strand
conda activate abricate #abricate to doublecheck rep genes
abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/input/str_replicons_preformatted_noref.fasta > /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/plasmidfinder/str_plasmidfinder_results_nofref.tab
conda deactivate

#added refs to str_replicons_preformatted.fasta as reference. 

cd /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/input
awk '/^>/ {if (NR>1) print ""; print $0; next} {printf "%s", $0} END {print ""}' str_replicons_preformatted.fasta > str_replicons_formatted.fasta 



conda activate abricate #abricate to doublecheck rep genes
abricate --db plasmidfinder /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/input/str_replicons_formatted.fasta > /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/plasmidfinder/str_plasmidfinder_results.tab
conda deactivate



####python####
python
input_file = '/home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/input/str_replicons_formatted.fasta'
output_file = '/home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/mobmess/completeinfo.txt'

with open(input_file, 'r') as fasta_file, open(output_file, 'w') as output:
    for line in fasta_file:
        if line.startswith('>'):
            output.write(line[1:])  # Write header without '>'

#ctrl +z
#Then added in 1 next to each
########

conda activate mobmess #mobmess to calculate ANI between pairs
mobmess systems \
    --sequences /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/input/str_replicons_formatted.fasta \
    --complete /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/mobmess/completeinfo.txt \
    --output /home/asommer3/Research/stablefly_wgs/analysis/plasmidanalysis/str/mobmess/str-mobmess \
    --threads 8
conda deactivate