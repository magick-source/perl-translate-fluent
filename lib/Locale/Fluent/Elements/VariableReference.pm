package Locale::Fluent::Elements::VariableReference;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has identifier => (
  is  => 'ro',
  default => sub { undef },
);

sub translate {
  my ($self, $variables) = @_;

#  use Data::Dumper;
#  print STDERR Dumper($self, $variables);

  return $variables->{ $self->identifier };
}

1;
