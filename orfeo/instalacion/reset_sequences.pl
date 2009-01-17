#!/usr/bin/perl

sub trim($);

open(ARCH,"secuencias.txt");

while(<ARCH>) {
  $sequence = $_;
  chop $sequence;
  $value = trim($sequence);
  print "ALTER SEQUENCE $value RESTART WITH 1;\n";
  print "ALTER SEQUENCE $value CACHE 1;\n";
}

close(ARCH);

# Perl trim function to remove whitespace from the start and end of the string
sub trim($) {
 my $string = shift;
 $string =~ s/^\s+//;
 $string =~ s/\s+$//;

 return $string;
}
