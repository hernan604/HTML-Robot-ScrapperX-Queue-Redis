# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 2;

BEGIN { use_ok( 'HTML::Robot::ScrapperX::Queue::Redis' ); }

my $object = HTML::Robot::ScrapperX::Queue::Redis->new ();
isa_ok ($object, 'HTML::Robot::ScrapperX::Queue::Redis');


