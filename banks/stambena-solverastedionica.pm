my $html = fetch_url('https://www.solverastedionica.hr/odluka-o-visini-nacinu-obracuna-i-naplate-kamata-180/180');
$mech->follow_link( url_regex => qr/kamata.*\.pdf/i );
return best_kamata_pdf_mpp('(.*)KAMATE NA KREDITE', '\b', '\s*\%');
