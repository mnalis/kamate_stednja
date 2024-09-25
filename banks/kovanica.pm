my $html = fetch_url('https://www.kovanica.hr/gradanstvo/stednja/orocena-stednja');

return max_of_all_pdf_links (undef, '\b([1-9]?\d)(?:[.,](\d{2}))?\s*\%', undef, $mech->find_all_links(text_regex => qr/(doplatna|profitna|rentna|freedom).*ednja.*\.pdf/));
