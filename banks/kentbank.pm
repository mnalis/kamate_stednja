my $html = fetch_url ('http://www.kentbank.hr/2608/orocena-stednja');

my $last_datum = 0;
my $last_link = undef;

# find latest link
foreach my $link ( $mech->find_all_links( text_regex => qr/Letak .*tednj/i ) ) {
	if (!defined $last_link) {
		$last_link = $link;
	}

	if (my ($d, $m, $y) = $link->text() =~ /.*(\d{2})\.(\d{2})\.(\d{4})\./) {
		my $datum = "$y$m$d";
		dbg 4, "test datum = $datum";
		if ($datum > $last_datum) {
			$last_datum = $datum;
			$last_link = $link;
		}
	}
}
dbg 3, "last datum=$last_datum";

$mech->get( $last_link->url() );
return best_kamata_pdf_mpp('(.*)DJE.*?JA.*?OTVORENA(.*)', '\b', '\s*\%');

