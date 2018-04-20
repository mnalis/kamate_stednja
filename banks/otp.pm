my $html = fetch_url('https://www.otpbanka.hr/hr/gradani/orocena-stednja-uz-promjenjivu-kamatnu-stopu');
$mech->follow_link( text_regex => qr/kamatne stope/i );
return best_kamata_pdf_mpp('(.*)HRK Dje.*?ja planirana.*?HRK planirana(.*)', '^\s*', '\s*$');
