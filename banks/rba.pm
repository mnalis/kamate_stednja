my $html = fetch_url('https://www.rba.hr/stednja-i-ulaganje/orocena-stednja/dokumentacija');
$mech->follow_link( text_regex => qr/kamatne stope na oro.*?ednju gra/i );
return best_kamata_pdf_mpp('VRSTA DEPOZITA(.*)', '\b', '\s');
