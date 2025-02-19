my $html = fetch_url('https://www.bks.hr/footer/naknade-i-kamatne-stope');
$mech->follow_link( text_regex => qr/pasivnim kamatnim stopama za stanov/i );
return best_kamata_pdf_def();
