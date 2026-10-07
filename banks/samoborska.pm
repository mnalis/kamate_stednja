my $html = fetch_url('https://www.sabank.hr/dokumenti/opce-informacije-o-orocenom-depozitu-za-gradane-2026-03-27/');
$mech->follow_link( url_regex => qr/oro.*depoz.*?\.pdf/i );
return best_kamata_pdf_def();
