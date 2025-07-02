my $html = fetch_url('https://www.sabank.hr/devizna---tednja/c61s4/');
$mech->follow_link( url_regex => qr/oro.*depoz.*?\.pdf/i );
return best_kamata_pdf_def();
