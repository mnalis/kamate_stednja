my $html = fetch_url('https://www.zaba.hr/home/footer/uvjeti-poslovanja/gradjani');
$mech->follow_link( text_regex => qr/kamatne stope.*ednju/i );
$mech->follow_link( url_regex => qr/kamatne.*\.pdf/i );
return best_kamata_pdf_mpp(undef, '^\s*', '\s*$');
