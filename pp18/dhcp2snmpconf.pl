#!/usr/bin/perl -w

use strict;

#HoHoH %subnet
my %subnet;
my $subnetindex=0;
my $rangeindex=0;
my $comment;

if (scalar(@ARGV)!=1) {
	die "Usage: dhcp2snmpconf.pl <dhcpd.conf>\n";
} else {

open (DHCPCONF,"<$ARGV[0]") or die "Can't open $ARGV[0]\n";

while (<DHCPCONF>) {
	if (/subnet /) {
		$subnetindex++;
		$rangeindex=0;
		$subnet{$subnetindex}{comment}=$comment;
	} elsif (/range/) {
		$rangeindex++;
		my $range=$_;
		$range =~ s/\s+range\s+//g;
		$range =~ s/;//;
		$range =~ s/ /-/;
		chomp $range;
		$subnet{$subnetindex}{range}{$rangeindex}=$range;
	} else {
	$comment = $_;
	$comment =~ s/\s*\#\s*//;
	chomp $comment;
	}
}

print <<EOF;
#The file is in key: value format and allows only two keys:
#
#leases: /var/lib/dhcp3/dhcpd.leases
#
#Location of the dhcpd.leases file. This file needs to be accessible by the script.
#
#pool: index, description, ip1-ip2, ip3-ip4...
#
#Defines a pool to monitor. index is a unique numeric index, description a textual
#description of this pool, and ip1-ip2, ip3-ip4, ... defines the ranges of IP addresses
#belonging to this pool.

leases: /var/lib/dhcpd/dhcpd.leases

EOF

for my $key1 (sort keys %subnet ) {
	print "pool: $key1,";
	print "$subnet{$key1}{comment},";
	for my $key2 (sort keys %{ $subnet{$key1}{range} }) {
		print "$subnet{$key1}{range}{$key2},";
	}
	print "\n";
}
}
