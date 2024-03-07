my $html = fetch_url('https://www.croatiabanka.hr/gradani/stednja/orocena-stednja/');
$mech->follow_link( url_regex => qr/kamatne-stope-na-.*-depozite.*?\.pdf/i );
return best_kamata_pdf_def();
