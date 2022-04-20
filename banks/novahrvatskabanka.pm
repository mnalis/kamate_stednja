# FIXME zapravo je https://www.novahrvatskabanka.hr/gradjani/stednja-i-ulaganje/in-stednja/ povoljnija, ali moramo raditi rucno izracun...
#return best_kamata_html_mpp ('https://www.novahrvatskabanka.hr/gradjani/stednja-i-ulaganje/happy-stednja/', undef, 'EKS iznosi\s+', '\s*\%');

my $nhb_best = 0;

# check one table
sub nhb_table($)
{
    my ($table) = @_;
    dbg 6, "nhb_table: $table";
    return 0 unless $table =~ /Prvih 12 mjeseci/i;
    dbg 5, "found Prvih 12";
    return 0 unless $table =~ /Drugih 12 mjeseci/i;
    dbg 5, "found Drugih 12";
    if ($table =~ m{<td.*?([1-9]?\d)[.,](\d{2})%</.*?<td.*?([1-9]?\d)[.,](\d{2})%</}is) {
        my $y1 = "$1.$2";
        my $y2 = "$3.$4";
        my $calc_kamata = int(((100 * (1+$y1/100) * (1+$y2/100) - 100) / 2) * 100) / 100;
        dbg 3, "NHB found: y1=$y1 y2=$y2, calc_kamata=$calc_kamata";
        $nhb_best = $calc_kamata if $calc_kamata > $nhb_best;
    }
}

dbg 5, "starting NHB";
my $html = fetch_url('https://www.novahrvatskabanka.hr/gradjani/stednja-i-ulaganje/in-stednja/');
dbg 8,"HTML=$html";
$html =~ s{<table.*?>(.*?)</table>}{nhb_table($1)}iesg;

return $nhb_best;
