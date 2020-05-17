package Locale::Fluent::Elements::BlockPlaceable;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has inline_placeable => (
  is  => 'ro',
  default => sub { undef },
);

sub translate {
  my ($self, $variables) = @_;

  if ($self->inline_placeable) {
    return $self->inline_placeable->translate( $variables );
  }

  return '';
}

1;
