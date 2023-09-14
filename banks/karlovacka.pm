my $html = fetch_url('https://www.kaba.hr/gradanstvo/orocena-eur-stednja/');
$mech->follow_link( url_regex => qr/bonus-.*?tednja.*?\.pdf/i );
return best_kamata_pdf_mpp ('depozit(.*)raskid', '\b', '\s*\%');


