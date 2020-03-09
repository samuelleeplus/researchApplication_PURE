This data sets were prepared to test the installation of Platanus-allee.  
The input reads were generated from the simulated diploid genome based on the genome of *Mycoplasma genitalium* G37.  
A script for the test, "run.sh", may be useful as the template for the actual cases.


# Description of directories

## test_run
Space for the test using four libraries: Illumina paired-ends, mate-pairs, PacBio long reads and 10X linked-reads.  
Please move to this directory and type
```
sh run.sh
```
If the installation of Platanus-allee is succeeded, the same result in the "test_run_result" below are obtained.

## test_run_result
Results corresponding to "test_run".

## reference_genome
Simulated diploid genome based on the genome of *Mycoplasma genitalium* G37 (accession, NC_000908.2).  
The simulator used was pIRS (Hu et al. 2012).

## reads
Input data sets for "test_run".
The tools to generate the libraries were as follows:

* Illumina paired-end (PE500) and mate-pair (MP3000)  
 pIRS (Hu et al. 2012).

* PacBio reads  
 PBSIM (Ono et al. 2013).  

* 10X linked-reads  
 pIRS and in-house scripts.


# Citations

1. pIRS  
 Hu, X. et al. pIRS: Profile-based Illumina pair-end reads simulator. Bioinformatics 28, 1533–5 (2012).

2. PBSIM  
 Ono, Y., Asai, K. & Hamada, M. PBSIM: PacBio reads simulator--toward accurate genome assembly. Bioinformatics 29, 119–21 (2013).
