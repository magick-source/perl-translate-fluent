package Locale::Fluent::Elements::NumberLiteral;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has text => (
  is  => 'ro',
  default => sub { undef },
);


sub translate {
  my ($self, $variables) = @_;

  return $self->text;
}

1;
