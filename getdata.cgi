#!/usr/bin/perl -wT
#
# Matija Nalis <mnalis-perl@voyager.hr> AGPLv3+ started on 2018-03-26
#
# ispis kretanje kamata na stednju u HR (JSON output za ChartJS graph)
#

use strict;
use autodie qw(:all);

use feature qw(say);

my $MAX_POINTS = 100;

my $DB='dbi:SQLite:dbname=kamate.db';
my $DBUSER='';
my $DBPASS='';

my @COLORS = qw (
	darkslategray darkolivegreen saddlebrown darkgreen darkred olive
	darkslateblue cadetblue mediumseagreen rosybrown peru steelblue yellowgreen
	darkblue limegreen goldenrod purple2 darkseagreen maroon3 red darkturquoise
	darkorange lime darkviolet crimson deepskyblue mediumpurple blue lightcoral
	greenyellow fuchsia dodgerblue palegoldenrod laserlemon plum paleturquoise
	violet palegreen aquamarine hotpink
	);

my $DEBUG = $ENV{DEBUG} || 0;
%ENV = ( PATH => '/usr/local/bin:/usr/bin:/bin' );


use FindBin;
use DBI;
use JSON qw( to_json );


# returns new color for graph
sub get_new_color() {
	my $color = pop @COLORS;
	if (! $color) { $color = sprintf ("#%06X", int(rand(256*256*256))); }
	return lc($color);
}

print "Content-Type: application/json\r\n\r\n";

my $cwd = $FindBin::Bin;
if ($cwd =~ m{^([a-z0-9_.\-\/]+)$}) { $cwd = $1 } else { die "invalid chars in CWD $cwd" }
chdir ($cwd) or die "can't chdir to cwd $cwd: $!";
umask 0077;

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

# check if there are too many elements to fit on screen?
my @datumi = sort keys %all;
my $count_full = scalar @datumi;
$DEBUG > 1 && say "full count is $count_full. Is it > $MAX_POINTS limit?";
if ($count_full > $MAX_POINTS) {
	# we always want to retain first and last dates
	my $prvi_datum = shift @datumi;
	my $zadnji_datum = pop @datumi;

	my $skip_nth = int ($count_full / $MAX_POINTS) + 1;
	$DEBUG > 0 && say "full count $count_full > $MAX_POINTS, trim it - preserve only every $skip_nth element + first and last";

	my @new_datumi = ($prvi_datum);

	# do the actual trimming
	for (my $i = 0; $i <= $#datumi; $i += $skip_nth) {
		my $d = $datumi[$i];
		$DEBUG > 3 && say "preserving datumi[$i]=$d";
		push @new_datumi, $d;
	}

	# restore preserved last date
	push @new_datumi, $zadnji_datum;
	@datumi = @new_datumi;
}

foreach my $datum (@datumi) {
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

	# save per-bank percentages in array
	push @JSON_labels, $datum;
	foreach my $bank (keys %banks_pct) {
		$DEBUG > 3 && say "adding to JSON_banks{$bank}: $banks_pct{$bank}";
		push @{$JSON_banks{$bank}}, $banks_pct{$bank};
	}
}


$DEBUG > 0 && say "labels=" . Dumper(\@JSON_labels);
$DEBUG > 0 && say "JSON_banks=" . Dumper(\%JSON_banks);

# generate and output JSON file
my %OUTPUT_JSON = ();
$OUTPUT_JSON{'labels'} = \@JSON_labels;

foreach my $bank (sort keys %JSON_banks) {
	my $color = get_new_color();
	my %dataset = (
		lineTension => 0.05,
		label => $bank,
		borderColor => $color,
		backgroundColor => $color,
		fill => 'false',
		data => $JSON_banks{$bank},
		);
	push @{$OUTPUT_JSON{'datasets'}}, \%dataset;
}

say to_json(\%OUTPUT_JSON, { ascii => 1, pretty => 1 } );
exit 0;
