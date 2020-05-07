package Locale::Fluent::Elements::InlineText;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has text => (
  is  => 'ro',
  default => sub { undef },
);

sub translate {
  my ($self) = @_;

  return $self->text;
}

1;
