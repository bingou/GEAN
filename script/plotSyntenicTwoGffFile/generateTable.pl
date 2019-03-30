#!perl -w
use strict;
use warnings FATAL => 'all';

my $refGff = $ARGV[0];
my $newGff = $ARGV[1];

my %gene_chr;
my %gene_position;

open INPUT, "$refGff";
while( my $line=<INPUT> ){
    if( $line=~/^(\d+)\s+\S+\s+gene\s+(\d+).*ID=(.*?);/ ){
        $gene_chr{$3}=$1;
        $gene_position{$3}=$2;
    }
}
close INPUT;

open INPUT, "$newGff";
while( my $line=<INPUT> ){
    if( $line=~/^(\d+)\s+\S+\s+gene\s+(\d+).*ID=(.*?);/ ){
        my $chr=$1;
        my $position=$2;
        my $gene=$3;
        $gene=~s/_\d+$//g;
        if( exists $gene_chr{$gene} ){
            print "$gene_chr{$gene}\t$gene_position{$gene}\t$chr\t$position\n";
        }else{
            print STDERR "$gene\n";
        }
    }
}
close INPUT;
