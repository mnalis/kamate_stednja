# Ministarstvo finiancija E-riznica - obveznice i trezorski zapisi
use JSON qw(decode_json);

my $json = fetch_url('https://e-riznica-mfin.gov.hr/api/v1/issue/emissions');
my $jref = decode_json $json;
my $jissues = $$jref{'issues'};

my $max = '0 but true';
#print "    mfin DEBUG start max=$max\n";
foreach my $href (@$jissues) {
    my $pct = $$href{'interestRateInitial'};
    #print "    daysleft=$$href{'daysLeft'} with pct=$pct\n";
    if ($$href{'daysLeft'} > 0) {
        if ($pct > $max) {
            $max = $pct 
        }
    }
    #print "      mfin DEBUG loop max=$max\n";
}

#print "    mfin DEBUG end max=$max\n";
return $max;

1;
