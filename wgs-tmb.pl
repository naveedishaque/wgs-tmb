#!/usr/bin/env perl

################################################
#                                              
# SCRIPT: wgs-tmb.pl
#
################################################
#
# AUTHOR: Naveed Ishaque (naveed.ishaque@charite.de)
# DATE: AUG 2020
#
################################################
#
# known issues: no file checking; no file type validation;
#
################################################

use strict;
use Getopt::Long qw(GetOptions);

##### PARSE INPUT #####

my $usage = "\nThis script calculate TMB from WGS data.\n\n\t $0 -s /path/to/somatic_snvs.VCF -i /path/to/somatic_indels.VCF -g /path/to/proteinCodingGenes.BED\n\n";

my $snv_file;
my $indel_file;
my $gene_file;
my $help;

GetOptions('snvs=s'   => \$snv_file,
           'indels=s' => \$indel_file,
           'genes=s'  => \$gene_file,
           'help'     => \$help);    

if ($help){
  print "$usage";
  exit;
}

if (!(defined $snv_file) || !(defined $gene_file)){
  warn "ERROR: You need to define an at least a SNV (\"$snv_file\") and gene file (\"$gene_file\")!\n$usage";
  exit;
}

if (defined $indel_file){
#  warn "indel file defined: \"$indel_file\"\n";
}

##### CALCULATE TMB #####

# calculate total coding region of genome

my $total_coding_bp = `bedtools sort -i $gene_file | bedtools merge -i - | awk -F'\t' '{sum=sum+\$3-\$2} END{print sum;}'`;
chomp ($total_coding_bp);
#warn "Total coding bp: $total_coding_bp\n";

# count number of coding SNVs not in dbSNP or 1kG (using the "ID=rs" tag) and not in cosmic (using the "tissue=" tag)

my $num_coding_snvs = `grep -v "ID=rs" $snv_file | grep -v "tissue=" | intersectBed -u -a - -b $gene_file | wc -l`;
chomp ($num_coding_snvs);
#warn "Total coding SNVs: $num_coding_snvs\n";

# count indels

my $num_coding_indels = 0;

if (-e $indel_file){
 $num_coding_indels = `grep -v "ID=rs" $indel_file | grep -v "tissue=" | intersectBed -u -a - -b $gene_file | wc -l`;
 chomp ($num_coding_indels);
# warn "Total coding indels: $num_coding_indels\n";
}

my $tmb = int(($num_coding_indels + $num_coding_snvs)*1000000/$total_coding_bp);

#warn "TMB: $tmb\n";
print "$tmb\n";
