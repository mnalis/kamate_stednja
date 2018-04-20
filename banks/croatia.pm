my $html = fetch_url('https://www.croatiabanka.hr/hr/gradani/stednja/orocena-stednja/');
$mech->follow_link( url_regex => qr/kamatne-stope-na-orocene-depozite.*?\.pdf/i );
return best_kamata_pdf_def();
