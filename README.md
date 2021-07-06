# wgs-tmb

A perl script to calculate tumor mutational burden (TMB) from whole genome sequencing (WGS) data. 

How to calculate TMB? The most cited article discussing clinical implcations of TMB look at exome of panel data:
 - Yarchoan et al, 2017, NEJM
 - Goodman et al, 2017, Molecular Cancer Therapeutics
 - Chalemrs et al, 2017, Genome Medicine

We use the Chalers method to calculate TMB:

"TMB was defined as the number of somatic, coding, base substitution, and indel mutations per megabase of genome examined. All base substitutions and indels in the coding region of 
targeted genes, including synonymous alterations, are initially counted before filtering as described below. Synonymous mutations are counted in order to reduce sampling noise. While 
synonymous mutations are not likely to be directly involved in creating immunogenicity, their presence is a signal of mutational processes that will also have resulted in nonsynonymous 
mutations and neoantigens elsewhere in the genome. Non-coding alterations were not counted. Alterations listed as known somatic alterations in COSMIC and truncations in tumor suppressor 
genes were not counted, since our assay genes are biased toward genes with functional mutations in cancer [63]. Alterations predicted to be germline by the somatic-germline-zygosity 
algorithm were not counted [64]. Alterations that were recurrently predicted to be germline in our cohort of clinical specimens were not counted. Known germline alterations in dbSNP 
were not counted. Germline alterations occurring with two or more counts in the ExAC database were not counted [65]. To calculate the TMB per megabase, the total number of mutations 
counted is divided by the size of the coding region of the targeted territory."

Summary:
 - all somatic mutations in coding regions
 - including synonymous
 - exlcuding COSMIC
 - excluding dbSNP EXAC
 - exlcuding germline
 - divided by the total protein coding length of the genome

## Input
 - VCF file of somative mutations from the DKFZ ICGC Pan-Cancer workflow
 - GTF/BED file of protein coding regions

## Prerequisites

- Developed using perl 5, version 26, subversion 1 (v5.26.1) built for x86_64-linux-gnu-thread-multi
- Perl lib GetOpts::Long
- bedtools v2.16.2

## conda setup

`conda install perl=5.26.2 bedtools=2.16.2`

## Usage

```
  perl wgs-tmb.pl
           -s /path/to/somatic_SNVs.VCF
           -i /path/to/somatic_indels.VCF
           -g /path/to/protein_coding_genes.bed
           -h 
```

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

 - v1.0.0: first working version 

## Authors/Copyright

Naveed Ishaque, Charite/BIH, 2020

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
