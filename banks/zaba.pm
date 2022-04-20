my $html;
#my $html = fetch_url('https://www.zaba.hr/home/footer/uvjeti-poslovanja/gradjani');	# uses JavaScript now 20181121 :(
my $json = fetch_url('https://www.zaba.hr/home/footer/filtriranjeUvjetaPoslovanja?k1=116&k2=130');
dbg 8, "JSON=$json";
if ($json =~ m{"naziv"\s*:\s*"([^"]*\.pdf)".+"idDokument"\s*:\s*(\d+).+"opis"\s*:\s*"([^"]*?kamatne stope.*?ednju[^"]*)}i) {
	my $filename="$1"; my $id="$2"; my $desc="$3";
	dbg 5, "found $1 ($3) with id=$2";
	my $url = "https://www.zaba.hr/home/med/dok/${id}/${filename}";
	$html = fetch_url($url);
}
#$mech->follow_link( text_regex => qr/kamatne stope.*?ednju/i );
#$mech->follow_link( url_regex => qr/kamatne.*?\.pdf/i );
return best_kamata_pdf_mpp(undef, '^\s*', '\s*$');
