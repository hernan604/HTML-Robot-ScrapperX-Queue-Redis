# -*- perl -*-
# t/001_load.t - check module loading and create testing directory
use Test::More;
use HTML::Robot::Scrapper;
use File::Path qw|make_path remove_tree|;
#use CHI;
use Cwd;
use Path::Class;
use Redis::Client;
use TestReader;     #my custom reader
use TestWriter;     #my custom writer
BEGIN { use_ok( 'HTML::Robot::Scrapper', 'use is fine' ); }

my $client = Redis::Client
  ->new( host => 'localhost', port => 6379 );

#   sub create_cache_dir {
#     my $dir  = dir(getcwd(), 'cache'); 
#     make_path( $dir, 'cache' );
#   }
#   &create_cache_dir;

my $robot = HTML::Robot::Scrapper->new(
    reader    => {                                                       # REQ
        class => 'TestReader',
#       args  => { #will be passed to ->new(here) in class^^
#         argument1 => 'xx'
#       },
    },
    writer    => {class => 'TestWriter',}, #REQ
    benchmark => {class => 'Default'},
    cache     => {
        class => 'Default',
        args  => {
            is_active => 0,
#           engine => CHI->new(
#                   driver => 'BerkeleyDB',
#                   root_dir => dir( getcwd() , "cache" ),
#           ),
        },
    },
    log       => {class => 'Default'},
    parser    => {class => 'Default'},
    queue     => {
        class => 'HTML::Robot::ScrapperX::Queue::Redis', 
        args => {
          client     => $client,
          queue_name => 'url_list',        
          url_visited => 'urls_visitedz',
        } 
    },
    useragent => {class => 'Default'},
    encoding  => {class => 'Default'},
    instance  => {class => 'Default'},
);
isa_ok ($robot, 'HTML::Robot::Scrapper', 'is obj scrapper');

$robot->start();

my $site_visited = {
    bbc     => 0,
    zap     => 0,
    google  => 0,
    uol     => 0,
};

foreach my $item ( @{ $robot->writer->data_to_save } ) {
  $site_visited->{bbc}      = 1 if $item->{ url } =~ m/bbc.+/ig;
  $site_visited->{zap}      = 1 if $item->{ url } =~ m/zap.+/ig;
  $site_visited->{google}   = 1 if $item->{ url } =~ m/google.+/ig;
  $site_visited->{uol}      = 1 if $item->{ url } =~ m/uol.+/ig;
}

ok( $site_visited->{ uol }      == 1, 'visited uol' );
ok( $site_visited->{ google }   == 1, 'visited google' );
ok( $site_visited->{ zap }      == 1, 'visited zap' );
ok( $site_visited->{ bbc }      == 1, 'visited bbc' );

done_testing();
