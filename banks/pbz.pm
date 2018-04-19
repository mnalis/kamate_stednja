my $html = fetch_url('https://www.pbz.hr/hr/gradani/stednja');
$mech->follow_link( text_regex => qr/kamatnim stopama/i );
return best_kamata_pdf_mpp('(.*?)e-Perspektiva.*?maksimalni iznos(.*?)Premium invest.*?inimalni iznos(.*)', '^', '\s*$');
