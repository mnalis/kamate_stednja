return best_kamata_html_mpp ('https://www.primorska.hr/hr/gradani/stednja-gradana',
	'Kamatne stope.*?<tbody(.*?)</tbody>.*?</table>',
	'<td.*?>(?=<.+?>)?',
	'\s*%\s*<.*?/td>'
);

