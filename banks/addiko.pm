my $html = fetch_url('https://www.addiko.hr/gradanstvo/stednja-i-ulaganje/orocena-stednja/');
$mech->follow_link( url_regex => qr/kamatne-stope.*?\.pdf/i );
return best_kamata_pdf_mpp ('(.*?)Hrvatska agencija za osiguranje depozita u skladu sa Zakonom.*Fiksne kamatne stope na namjenski oro(.*)', '\b', '\s*\%');
