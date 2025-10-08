my $html = fetch_url('https://ikb.hr/gradani/korisne-informacije/opci-uvjeti/kamatne-stope');
$mech->follow_link( text_regex => qr/kamatne stope na .*pologe/i );
return best_kamata_pdf_mpp('(.*)OTVORENA DJE', '\b', '\s*\%');
