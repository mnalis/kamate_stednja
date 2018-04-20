my $html = fetch_url('https://www.sabank.hr/kunska-tednja/c1s62/');
$mech->follow_link( url_regex => qr/stednja.*?\.pdf/i );
return best_kamata_pdf_def();
