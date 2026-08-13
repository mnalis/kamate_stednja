my $html = fetch_url('https://www.otpbanka.hr/gradani/planirana-stednja', 1);
$mech->follow_link( text_regex => qr/kamatnom stopom/i );
return best_kamata_pdf_mpp('(.*)', '^\s*', '\s*$');
