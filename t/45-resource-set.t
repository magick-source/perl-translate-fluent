#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;


BEGIN {
    use_ok( 'Locale::Fluent' ) || print "Bail out!\n";
}

my $path = $0;
$path =~ s{t/.*.t}{test_files/basic.flt};

my $resource_set = Locale::Fluent::Parser::parse_file( $path );
ok( $resource_set, "Defined resource_set");

BAIL_OUT("Undefined resource_set")
  unless $resource_set;

isa_ok( $resource_set, "Locale::Fluent::ResourceSet");

my $fullname = $resource_set->translate("fullname");
is( $fullname, 'theMage Merlin mage dude', "Got a proper fullname");

my $pi = $resource_set->translate('math-pi');
is( $pi, '3.1415', "We have got pi: $pi");

my $piv = $resource_set->translate('math-value-of-pi', {});
is( $piv, 'The value of constant pi is 3.1415', "We have got it: [$piv]");

my $no_message = $resource_set->translate('math-constant',
                  {name => 'pi', value => '42'}
                );
is( $no_message, undef, 'should not get a translation of a term');

my $missing = $resource_set->translate('this-is-no-resource-at-all');
is( $missing, undef, 'should not get a translation of a missing resource');


my $term    = $resource_set->get_term('math-constant');
isa_ok( $term, "Locale::Fluent::Elements::Term");

my $no_term = $resource_set->get_term('math-value-of-pi');
is($no_term, undef, 'should not get a message when asking for a term');

done_testing();
