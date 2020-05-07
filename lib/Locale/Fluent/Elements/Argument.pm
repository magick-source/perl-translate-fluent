package Locale::Fluent::Elements::Argument;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(
      named_argument
      inline_expression
    )] => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{named_argument}     = delete $args{ NamedArgument };
  $args{inline_expression}  = delete $args{ InlineExpression };

  $class->$orig( %args );
};

sub identifier {
  my ($self) = @_;

  if ($self->named_argument) {
    return $self->named_argument->identifier;
  }

  return;
}

sub translate {
  my ($self, $variables) = @_;

  if ($self->named_argument) {
    return $self->named_argument->translate( $variables );
  } elsif ($self->inline_expression) {
    return $self->inline_expression->translate( $variables );
  }

  return;
}


1;
