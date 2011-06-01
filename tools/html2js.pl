#!/usr/bin/perl
use strict;
my $argCount = $#ARGV + 1;

sub usage {
    print "HTML to JavaScript string converter\n";
    print "Usage: ./html2js.pl <html-file> <js-file>\n";
}

if ( $argCount < 2) {
    usage;
    exit(0);
}

my $htmlfile = $ARGV[0];
my $jsfile = $ARGV[1];

print "ARGS($argCount): ($htmlfile) ($jsfile)\n";

# open the input HTML file and read it into a string
open (IN, "$htmlfile") || die("Error opening file: $htmlfile $!");
undef $/;          
my @infile = <IN>; #split(<IN>,'\n');
close (IN) || die("Error closing file: $htmlfile $!");

# create the output Javascript file.
open (OUT, ">$jsfile") || die("Error creating file: $jsfile $!");
print OUT "var code=";

my $i = 0;
my $line;
#my $linecount = $#infile;
#print "Scanning $linecount lines...\n";
foreach $line (@infile){
	chomp($line);
	my $i++;
	$line =~ s/'/\'/g;
	$line =~ s/^/'/g;
	$line =~ s/\n//g;
	$line =~ s/$/';/g;
	print OUT "$line";
}
close (OUT) || die("Error closing file: $jsfile $!");
print "$htmlfile > $jsfile: done.\n";
exit(0);
