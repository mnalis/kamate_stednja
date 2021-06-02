my $DEBUG = $ENV{DEBUG} || 9;

$DEBUG > 6 && print "about to fetch html\n";
my $html = fetch_url('https://www.pbz.hr/gradjani/orocena-stednja.html');
$DEBUG > 6 && print "searching html\n";
$mech->follow_link( text_regex => qr/kamatne stope/i );
$DEBUG > 6 && print "searching pdf\n";
return best_kamata_pdf_mpp(undef, '^', '\s*$');
