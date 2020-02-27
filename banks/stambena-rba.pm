{
	#local $USER_AGENT = $USER_AGENT_FAKE;
	local $USER_AGENT = '';
	dbg 3, "local UA=$USER_AGENT";
return best_kamata_html_regex ('https://www.raiffeisenstambena.hr/stambena-stednja',
	'Kamatna stopa(.*)Primjer izra.*?una',
	'\b([1-9]?\d)[.,](\d{1,2})\s*%'
);
}
