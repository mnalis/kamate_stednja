return best_kamata_html_mpp ('https://www.poba.hr/gradani/orocena-stednja/',
	'KAMATNE(.*?)NAKNAD',
	'^\s+',
	'\s*$'
#	'<td.*?>\s*',
#	'<.*?/td>'
);

