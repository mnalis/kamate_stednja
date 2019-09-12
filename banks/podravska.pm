return best_kamata_html_mpp ('http://www.poba.hr/index.php?cat=godisnje_kamatne_stope_gradana',
	'Kunski i devizni oro.*? depoziti.*?<table(.*?)Efektivne kamatne stope jednake',
	'<td.*?>',
	'<.*?/td>'
);

