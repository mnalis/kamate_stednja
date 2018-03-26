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
my $sth = $dbh->prepare ('SELECT datum, bank, pct10 FROM kamate ORDER BY datum') or die $dbh->errstr;
$sth->execute () or die $sth->errstr;

my %all = ();
while (my $href = $sth->fetchrow_hashref) {
	push @{$all{$$href{'datum'}}}, { bank => $$href{'bank'}, pct => $$href{'pct10'}/100 };
}

use Data::Dumper;
say Dumper(\%all);


foreach my $datum (keys %all) {
	my $day_aref = $all{$datum};
	say "za datum $datum";
	foreach my $bank_href (@$day_aref) {
		say "\tbanka=" . $$bank_href{'bank'} . "\tpct=" . $$bank_href{'pct'};
	}
}