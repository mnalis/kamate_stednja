my $html = fetch_url('https://www.addiko.hr/gradanstvo/stednja-i-ulaganje/orocena-stednja/');
my $pdf_regex = qr/kamatne-stope.*?\.pdf/i;

$mech->follow_link( url_regex => qr/naknade-gradanstvo/i );
@pdfs = $mech->find_all_links( url_regex => $pdf_regex );
my $last_pdf = scalar @pdfs;

$mech->follow_link( url_regex => $pdf_regex, n => $last_pdf );
return best_kamata_pdf_mpp ('kamatne stope na .*? oro(.*)', '\b', '\s*\%');
