package Locale::Fluent::Elements::MessageReference;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(
      identifier
      attribute_accessor
    )] => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{identifier}         = delete $args{ Identifier };
  $args{attribute_accessor} = delete $args{ AttributeAccessor };

  $class->$orig( %args );
};

1;
