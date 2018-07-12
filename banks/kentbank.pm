my $html = fetch_url ('http://www.kentbank.hr/2608/orocena-stednja');
$mech->follow_link( text_regex => qr/Letak .*tednje/i );
return best_kamata_pdf_mpp('(.*)DJE.*?JA.*?OTVORENA(.*)', '\b', '\s*\%');

