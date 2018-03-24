my $html = fetch_url('https://www.raiffeisenstambena.hr/stambena-stednja');
if ($html =~ /(.*)Primjer izra/si) { $html = $1 } else { die "$html\ndoesn't match our regexp" }
return find_max_kamata_regex($html, '\b([1-9]?\d)[.,](\d{1,2})\s*%');
