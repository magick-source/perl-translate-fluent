package Locale::Fluent::Elements::ArgumentList;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has argument => (
  is  => 'ro',
  default => sub { [] },
);

around BUILDARGS => sub {
  my ($orig, $self, %args) = @_;

  $args{ argument } = delete $args{ Argument };
  $args{ argument } = [ $args{ argument } ]
    unless ref $args{argument} eq 'ARRAY';

  $args{ argument } = [map { {Argument => $_ } }
                        @{ $args{ argument } } ];

  $self->$orig( %args );
};

sub to_variables {
  my ($self, $variables ) = @_;

  my %vars;

  my $pos = 0;
  for my $arg (@{ $self->argument // [] }) {
    my $id = $arg->identifier;
    unless ($id ) {
      $id = "position_$pos";
      $pos++;
    }
    $vars{ $id } = $arg->translate( $variables );
  }

  return \%vars;
}


1;
