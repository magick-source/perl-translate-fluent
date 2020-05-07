package Locale::Fluent::Elements::Message;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(identifier pattern attributes)] => (
  is  => 'ro',
  default => sub { undef },
);

sub translate {
  my ($self, $variables) = @_;

  return $self->pattern->translate( $variables );
}


1;
