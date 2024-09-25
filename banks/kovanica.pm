my $html = fetch_url('https://www.kovanica.hr/gradanstvo/stednja/orocena-stednja');

# FIXME - ne pronalazi kamate bez decimalnog mjesta, npr. 2% u FREEDOM stednji
return max_of_all_pdf_links (undef, '\b([1-9]?\d)[.,](\d{2})\s*\%', undef, $mech->find_all_links(text_regex => qr/(doplatna|profitna|rentna|freedom).*ednja.*\.pdf/));
