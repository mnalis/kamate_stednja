my $html = fetch_url('https://www.bks.hr/orocena-stednja');
$mech->follow_link( url_regex => qr/kamatne_stope.*?\.pdf/i );
return best_kamata_pdf_def();
