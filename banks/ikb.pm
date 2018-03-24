my $html = fetch_url('http://www.ikb.hr/Default.aspx?art=560');
$mech->follow_link( text_regex => qr/kamatne stope na depozite/i );
return best_kamata_pdf_mpp('POLOGE U KUNAMA(.*?RISPARMIO DI TIPO APERTO.*?annuo- oltre)', '\b', '\s*\%');

