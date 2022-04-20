dbg 6, 'about to fetch html';
my $html = fetch_url('https://www.pbz.hr/gradjani/orocena-stednja.html');
dbg 6, 'searching html';
$mech->follow_link( text_regex => qr/kamatne stope/i );
dbg 6, 'searching pdf';
return best_kamata_pdf_mpp(undef, '^', '\s*$');
