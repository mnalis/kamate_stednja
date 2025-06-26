return best_kamata_html_regex ('http://www.solverastedionica.hr/stambena-stednja/tarifa-spore-stednje/33',
	undef,
	'\b([1-9]?\d)[.,](\d{1,2})\s*(?:<[^>]+>)?(?:&[^;]+;)?(?:</[^>]+>)?\s*%'
);
