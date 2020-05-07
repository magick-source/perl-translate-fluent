package Locale::Fluent::Elements::CallArguments;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has argument_list => (
  is  => 'ro',
  default => sub { [] },
);


sub to_variables {
  my ( $self, $variables ) = @_;

  return unless $self->argument_list;

  return $self->argument_list->to_variables;
}

1;
