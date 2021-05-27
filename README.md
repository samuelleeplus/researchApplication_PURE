# Program for Undergraduate Research (PURE)
Developing computational strategies for assembly of heterozygous DNA sequence data

## Project Abstract/Description
Rapid technical improvements in high-throughput DNA sequencing technology have made it possible to obtain large amounts of genetic sequence data for almost any biological organism. However, what all current sequencing technologies have in common is that the cellular DNA must first be split into thousands or millions of small fragments, each of which are sequenced individually. These sequence fragments (called 'reads') must then be compared, their overlapping regions identified, and merged to recover the original genome sequence. This process is called "genome assembly" and presents a significant computational challenge, especially given the presence of errors in the raw read data. While a number of different specialized programs have been developed for sequence assembly, in most cases they assume that the DNA sequence being reassembled is essentially haploid (that is, each element is present in a single copy). In reality, the majority of eukaryotic organisms are diploid or polyploid, having 2 or multiple copies of each chromosome. Therefore a single sample contains multiple copies of each gene, which are often non-identical. Separating these different copies (alleles) and determining which of them originated from the same DNA strand (haplotypes) is essential to answer a number of important biological questions including inheritance of traits, understanding the genetic basis of diseases, etc. In this project, the student will work on a large whole-genome sequencing dataset from hazelnut (Corylus avellana), an agriculturally important tree species with a diploid genome that is believed to be highly heterozygous. Initial genome assemblies using existing tools with this dataset have produced results significantly larger than the expected genome size, and containing a large number of duplicated elements. The project will involve using existing tools and developing new strategies to address the issue of heterozygosity and develop a more complete and realistic genome assembly.


## Project Supervisor 
Dr. Stuart J. Lucas
https://sunum.sabanciuniv.edu/?page_id=1255


For access to further data, please send email/request to: samuellee@sabanciuniv.edu

## Datasets
This data sets were prepared to test the installation of Platanus-allee.  
The input reads were generated from the simulated diploid genome based on the genome of *Mycoplasma genitalium* G37.  

# Description of directories

## test_run

Under this directory, you can run the bash script 

```
run.sh
```

to get results in *.log, .fasta, .tsv & .bed* files in test_run_results directory. 


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
