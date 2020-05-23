#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

BEGIN {
  use_ok('Locale::Fluent') || print "Bail out!\n";
}

my $path = $0;
$path =~ s{t/20-base-methods.t}{test_files/basic.flt};

my $resource_set = Locale::Fluent->parse_file( $path );
isa_ok( $resource_set, "Locale::Fluent::ResourceSet" );

$path =~ s{basic.flt}{slurp};
my $resource_group = Locale::Fluent->slurp_directory( $path );
isa_ok( $resource_group, "Locale::Fluent::ResourceGroup");

# the specifics of ResourceSet and ResourceGroup will be tested
# somewhere else.

done_testing();

