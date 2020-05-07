package Locale::Fluent::Elements::FunctionReference;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(
      identifier
      call_arguments
    )] => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{call_arguments}     = delete $args{ CallArguments };

  $class->$orig( %args );
};

1;
