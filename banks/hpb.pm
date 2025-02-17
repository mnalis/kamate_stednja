my $html = fetch_url('https://www.hpb.hr/hr/stednja/552');
$mech->follow_link( url_regex => qr/VISINI(%20| )KS.*\.pdf/i );
return best_kamata_pdf_mpp('ORO.*?DEPOZIT(.*?)se ne ugovara od.*?EDNJA 4(.*?)depozite otvorene do 12. lipnja 2017. godine', '\b', '\s*\%\s*[^*]');
