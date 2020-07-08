my $html = fetch_url('https://www.addiko.hr/gradanstvo/stednja-i-ulaganje/orocena-stednja/');
$mech->follow_link( url_regex => qr/kamatne-stope.*?\.pdf/i );
return best_kamata_pdf_mpp ('kamatne stope na oročene depozite(.*)PREMIJOM ugovorene do', '\b', '\s*\%');
