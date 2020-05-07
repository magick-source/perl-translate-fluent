package Locale::Fluent::Elements::NamedArgument;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(
      identifier
      string_literal
      number_literal
    )] => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{identifier}         = delete $args{ Identifier };
  $args{string_literal}     = delete $args{ StringLiteral };
  $args{number_literal}     = delete $args{ NumberLiteral };

  $class->$orig( %args );
};

sub translate {
  my ($self) = @_;

  my $part = $self->string_literal
          // $self->number_literal;

  return ref $part ? $part->translate : $part;
}

1;
