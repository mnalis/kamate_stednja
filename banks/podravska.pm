return best_kamata_html_mpp ('https://www.poba.hr/gradani/orocena-stednja/',
	'KAMATNE(.*?)NAKNADE',
	'<td.*?>\s*',
	'<.*?/td>'
);

