my $k1 = best_kamata_html_def ('https://www.kovanica.hr/gradanstvo/stednja/orocena-stednja');
my $k2 = best_kamata_html_def ('https://www.kovanica.hr/gradanstvo/stednja/orocena-stednja/akcijska-stednja');

return ($k1 > $k2) ? $k1 : $k2;
