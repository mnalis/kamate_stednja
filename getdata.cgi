#!/usr/bin/perl -wT

use strict;
use autodie qw(:all);

use feature qw(say);

my $DB='dbi:SQLite:dbname=kamate.db';
my $DBUSER='';
my $DBPASS='';

my $DEBUG = $ENV{DEBUG} || 0;
%ENV = ( PATH => '/usr/local/bin:/usr/bin:/bin' );


use FindBin;
use WWW::Mechanize;
use DBI;

my $dbh = DBI->connect("$DB","$DBUSER","$DBPASS", { Taint => 1, ReadOnly => 1 });
my $sth = $dbh->prepare ('SELECT datum, bank, pct10 FROM kamate') or die $dbh->errstr;
$sth->execute () or die $sth->errstr;

my %all = ();
my %banks_zero = ();
while (my $href = $sth->fetchrow_hashref) {
	push @{$all{$$href{'datum'}}}, { bank => $$href{'bank'}, pct => $$href{'pct10'}/100 };
	$banks_zero{$$href{'bank'}} = undef;	# create a hash key, with empty value
}

if ($DEBUG) { use Data::Dumper; }
$DEBUG > 5 && say "all=" . Dumper(\%all);
$DEBUG > 8 && say "banks_zero=" . Dumper(\%banks_zero);

my @JSON_labels = ();
my %JSON_banks = ();

foreach my $datum (sort keys %all) {
	my $day_aref = $all{$datum};
	$DEBUG > 1 && say "za datum $datum";

	# fill $bank_href with percentages for each bank, leaving undef if we miss data for some bank
	my %banks_pct = %banks_zero;
	$DEBUG > 8 && say "pre=", Dumper(\%banks_pct);
	foreach my $bank_href (@$day_aref) {
		$banks_pct{$$bank_href{'bank'}} =  $$bank_href{'pct'};
		$DEBUG > 3 && say "\tbanka=" . $$bank_href{'bank'} . "\tpct=" . $$bank_href{'pct'};
	}
	$DEBUG > 2 && say "post=", Dumper(\%banks_pct);

	# save
	push @JSON_labels, $datum;
	foreach my $bank (keys %banks_pct) {
		say "bank=$bank";
		push @{$JSON_banks{$bank}}, $banks_pct{$bank};
	}
}


$DEBUG > 0 && say "labels=" . Dumper(\@JSON_labels);
$DEBUG > 0 && say "JSON_banks=" . Dumper(\%JSON_banks);

