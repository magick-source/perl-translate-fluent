package Locale::Fluent::Elements::Identifier;

use Moo;
extends 'Locale::Fluent::Elements::Base';

use overload
  '""'    => 'identifier',
  'bool'  => 'boolify';

has text => (
  is  => 'ro',
  default => sub { undef },
);

sub boolify { 1 }

sub identifier {
  my ($self) = @_;

  return $self->text;
}

1;
