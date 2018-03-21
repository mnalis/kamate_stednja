return best_kamata_html_mpp ('http://www.poba.hr/index.php?cat=godisnje_kamatne_stope_gradana',
	'Kunski oro.*? depoziti.*?<table(.*?)</table>',
	'<td.*?>',
	'<.*?/td>'
);

