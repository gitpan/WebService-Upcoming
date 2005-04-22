# *****************************************************************************
# *                                                                           *
# * WebService::Upcoming test                                                 *
# *                                                                           *
# *****************************************************************************


# Set-up **********************************************************************
use Test;
BEGIN
{
	plan( 'tests' => 6 );
}


# Uses ************************************************************************
use WebService::Upcoming;


# Code ************************************************************************
my $keyy;
my $upco;
my $objc;

$keyy = '*** UPCOMING API KEY HERE ***';
die("\n\n\n\nYou must replace the text...\n\n".
 "\t*** UPCOMING API KEY HERE ***\n\n".
 "...in ./t/test.t with your own API key in order for the test to ".
 "succeed.\n\n\n\n") if ($keyy !~ /[a-z0-9]{10}/);
$upco = WebService::Upcoming->new($keyy);

$objc = $upco->call('event.getInfo',{ 'event_id' => 1 });
ok(defined($objc));                                          # No error?
ok($objc->[0]->id() == 1);                                   # Right event?
ok($objc->[0]->name() eq 'Tori Amos, Ben Folds');            # Right name?
ok($objc->[0]->venue_id() == 1);                             # Right venue?

$objc = $upco->call('event.getInfo');
ok($upco->err_text() eq 'Missing valid event_id parameter'); # Missing arg

$objc = $upco->call('imaginary.method',{ 'pretend.argument' => 1 });
ok($upco->err_text() =~ /^Unknown Upcoming API method: /);   # Bad method
