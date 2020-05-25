use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Locale::Fluent',
    AUTHOR           => q{theMage <neves@cpan.org>},
    VERSION_FROM     => 'lib/Locale/Fluent.pm',
    ABSTRACT_FROM    => 'lib/Locale/Fluent.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Regexp::Grammars'  => 0,
        'Moo'               => 0,
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Locale-Fluent-*' },
);
