my $html = fetch_url('http://www.kaba.hr/gradanstvo/orocena-kunska-stednja/');
$mech->follow_link( url_regex => qr/bonus-.*?tednja.*?\.pdf/i );
return best_kamata_pdf_mpp ('depozit(.*)raskid', '\b', '\s*\%');


