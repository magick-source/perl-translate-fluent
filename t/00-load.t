#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Locale::Fluent' ) || print "Bail out!\n";
}

diag( "Testing Locale::Fluent $Locale::Fluent::VERSION, Perl $], $^X" );
