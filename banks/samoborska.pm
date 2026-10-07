my $html = fetch_url('https://www.sabank.hr/proizvodi/stednja-u-eurima-ili-devizama/');
$mech->follow_link( url_regex => qr/informacije-o-orocenom/i );
dbg 4, "followed " . $mech->uri;
$mech->follow_link( url_regex => qr/oro.*depoz.*?\.pdf/i );
dbg 4, "fetched " . $mech->uri;
return best_kamata_pdf_def();
