my $html = fetch_url('http://bks.hr/BKSWebp/BKS/bks_hr/Gradanstvo/Stednja/Orocena_stednja/index.jsp');
$mech->follow_link( url_regex => qr/kamatne_stope.*?\.pdf/i );
return best_kamata_pdf_def();
