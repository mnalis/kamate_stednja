my $html = fetch_url('https://www.pbz.hr/gradjani/orocena-stednja.html');
$mech->follow_link( text_regex => qr/kamatne stope/i );
return best_kamata_pdf_mpp(undef, '^', '\s*$');
