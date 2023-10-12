my $html = fetch_url('https://www.sabank.hr/devizna---tednja/c61s4/');
$mech->follow_link( url_regex => qr/oroc_depoz.*?\.pdf/i );
return best_kamata_pdf_def();
