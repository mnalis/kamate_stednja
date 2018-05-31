my $html = fetch_url('https://www.hpb.hr/opci-uvjeti-poslovanja');
$mech->follow_link( url_regex => qr/kamatne_stope.*?\.pdf/i );
return best_kamata_pdf_mpp('NENAMJENSKI.*?DEPOZIT(.*?)DEPOZIT S .*?EKRATNIM UPLATAMA', '\b', '\s*\%\s*[^*]');
