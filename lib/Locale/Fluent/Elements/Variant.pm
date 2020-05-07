package Locale::Fluent::Elements::Variant;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(
      identifier
      pattern
    )] => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{identifier}   = delete $args{ Identifier };
  $args{pattern}      = delete $args{ Pattern };

  $class->$orig( %args );
};

sub translate {
  my ($self, $variables) = @_;

  return $self->pattern->translate( $variables );
}

1;
