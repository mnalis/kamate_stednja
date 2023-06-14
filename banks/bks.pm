my $html = fetch_url('https://www.bks.hr/footer/naknade-i-kamatne-stope');
$mech->follow_link( text_regex => qr/kamatnim stopama za fizi/i );
return best_kamata_pdf_def();
