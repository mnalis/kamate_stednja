my $html = fetch_url('https://www.addiko.hr/gradanstvo/stednja-i-ulaganje/orocena-stednja/');
$mech->follow_link( url_regex => qr/kamatne-stope.*?\.pdf/i );
return best_kamata_pdf_mpp ('(.*)Novi depoziti u valuti USD ne ugovaraju se za razred', '\b', '\s*\%');
