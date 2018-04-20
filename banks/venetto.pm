my $html = fetch_url('http://www.venetobanka.hr/stednja');
$mech->follow_link( text_regex => qr/STANDARDNA .*?TEDNJA/i );
return best_kamata_pdf_mpp('VRSTA DEPOZITA(.*)', '\b', '\b');
