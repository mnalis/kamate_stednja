my $html = fetch_url('https://www.splitskabanka.hr/gradani/stednja-i-ulaganje/kamatne-stope');
$mech->follow_link( text_regex => qr/kamatne stope na/i );
return best_kamata_pdf_mpp('KAMATNE STOPE NA STANDARDNU(.*)', '\b', '\b');
