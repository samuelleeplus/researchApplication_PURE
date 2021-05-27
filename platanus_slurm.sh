#!/bin/bash
#
# CompecTA (c) 2018
#
# NAMD job submission script
#
# TODO:
#   - Set name of the job below changing "NAMD" value.
#   - Set the requested number of nodes (servers) with --nodes parameter.
#   - Set the requested number of tasks (cpu cores) with --ntasks parameter. (Total accross all nodes)
#   - Select the partition (queue) you want to run the job in:
#     - short : For jobs that have maximum run time of 120 mins. Has higher priority.
#     - mid   : For jobs that have maximum run time of 1 days. Lower priority than short.
#     - long  : For jobs that have maximum run time of 7 days. Lower priority than long.
#     - longer: For testing purposes, queue has 15 days limit but only 2 nodes.
#     - cuda  : For CUDA jobs. Solver that can utilize CUDA acceleration can use this queue. 7 days limit.
#   - Set the required time limit for the job with --time parameter.
#     - Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds"
#   - Put this script and all the input file under the same directory.
#   - Set the required parameters, input/output file names below.
#   - If you do not want mail please remove the line that has --mail-type and --mail-user. If you do want to get notification emails, set your email address.
#   - Put this script and all the input file under the same directory.
#   - Submit this file using:
#      sbatch slurm_submit.sh
#
# -= Resources =-
#
#SBATCH --job-name=Platanus-slurm
#SBATCH --account=users
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --qos=short
#SBATCH --partition=short
#SBATCH --time=120
#SBATCH --output=%j-slurm.out
#SBATCH --mail-type=ALL
# #SBATCH --mail-user=foo@bar.com

# This is where to put variables
####################
# Parameters for multi-threading, temporary directory, memory space and output file names.
# Although these are optional, please check if they are suitable for your environment.
####################
num_threads=8
tmp_dir=.
memory_GB=8
out_prefix=SlmOut

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


################################################################################
source /etc/profile.d/modules.sh
echo "source /etc/profile.d/modules.sh"
################################################################################

# Module File
#echo "Loading Platanus"
module load platanus2-2.0.1
#echo

echo ""
echo "======================================================================================"
env
echo "======================================================================================"
echo ""

echo "======================================================================================"
# Set stack size to unlimited
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
echo "======================================================================================"

#This is where the commands go
echo "Job ID $SLURM_JOBID" 
echo "Date is `date`" 
echo ""
echo "Running Platanus commands"

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


echo "job completed."
