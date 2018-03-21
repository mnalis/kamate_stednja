return best_kamata_html_mpp ('http://www.jadranska-banka.hr/Default.aspx?sifraStranica=66',
	'<table.*?kamatna stopa.*?<tr(.*?)</table>',
	'<td.*?>',
	'</td>'
);

