my $html = fetch_url('http://bks.hr/BKSWebp/BKS/bks_hr/Gradanstvo/Stednja/Orocena_stednja/index.jsp');
$mech->follow_link( url_regex => qr/kamatne_stope.*\.pdf/i );

die $mech->response() if !$mech->success();
#print "html=$html";
my $pdf = $mech->content();

{
	use File::Temp qw( tempfile );
	my ($temp_fd, $tempfile) = tempfile();
	$mech->save_content($tempfile);
	open my $txt_fd, '-|', 'pdftotext', $tempfile, '-';
	my $text = do { local $/; <$txt_fd>; };
	return find_max_kamata_pp($text, undef, '%');
}
