# bash/zsh script to execute Platanus-allee

####################
# Parameters for multi-threading, temporary directory, memory space and output file names.
# Although these are optional, please check if they are suitable for your environment.
####################
num_threads=1
tmp_dir=.
memory_GB=8
out_prefix=out

# Only required for long-read input (PacBio or Oxford Nanopore).
minimap2_path=minimap2
####################


####################
# Input reads
####################
PE500=../reads/Illumina_PE500/R*.fq
MP3000=../reads/Illumina_MP3000/R*.fq
PacBio=../reads/PacBio/subreads.fq
TenX=../reads/10X/barcoded.fq
####################


####################
# Commands
####################
platanus_allee assemble -t ${num_threads} -tmp ${tmp_dir} -m ${memory_GB} -o ${out_prefix} \
-f $PE500 \
2>${out_prefix}.assembleLog


platanus_allee phase -t ${num_threads} -tmp ${tmp_dir} -o ${out_prefix} -mapper ${minimap2_path} \
-c ${out_prefix}_contig.fa ${out_prefix}_junctionKmer.fa \
-IP1 $PE500 -OP2 $MP3000 -p $PacBio -x $TenX \
2>${out_prefix}.phaseLog


platanus_allee consensus -t ${num_threads} -tmp ${tmp_dir} -o ${out_prefix} -mapper ${minimap2_path} \
-c ${out_prefix}_primaryBubble.fa ${out_prefix}_nonBubbleHomoCandidate.fa \
-IP1 $PE500 -OP2 $MP3000 -p $PacBio -x $TenX \
2>${out_prefix}.consensusLog
####################


####################
# Results
####################
# Phased Blocks:
#     Primary bubbles     : out_primaryBubble.fa
#     Secondary bubbles   : out_secondaryBubble.fa
#     Non-bubble scaffolds: out_nonBubbleHomoCandidate.fa, out_nonBubbleHetero.fa
#     All blocks above    : out_allPhaseBlock.fa
#
# Consensus scaffolds     : out_consensusScaffold.fa
####################
