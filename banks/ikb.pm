my $html = fetch_url('http://www.ikb.hr/hr/orocena-stednja');
$mech->follow_link( text_regex => qr/letak.*kamatn.*stop.*pdf/i );
return best_kamata_pdf_mpp('UVJETI ORO.*?ENOG NOV.*?ANOG POLOGA(.*)', '\b', '\b');
