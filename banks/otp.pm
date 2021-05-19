my $html = fetch_url('https://www.otpbanka.hr/hr/gradani/planirana-stednja');
$mech->follow_link( text_regex => qr/kamatne stope/i );
return best_kamata_pdf_mpp('(.*)', '^\s*', '\s*$');
