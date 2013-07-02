

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'HTML::Robot::ScrapperX::Queue::Redis',
    VERSION_FROM => 'lib/HTML/Robot/ScrapperX/Queue/Redis.pm', # finds \$VERSION
    AUTHOR       => 'Hernan Lopes (hernan@cpan.org)',
    ABSTRACT     => 'Redis based queue for HTML::Robot::Scrapper',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                    },
);
