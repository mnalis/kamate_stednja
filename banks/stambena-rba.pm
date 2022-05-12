return best_kamata_html_regex ('https://www.rba.hr/stednja-i-ulaganje/stambena-stednja',
	'Kamatna stopa(.*)uz fiksnu kamatnu stopu ',
	'\b([1-9]?\d)[.,](\d{1,2})\s*%'
);
