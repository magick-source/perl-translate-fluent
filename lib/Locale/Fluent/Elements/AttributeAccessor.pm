package Locale::Fluent::Elements::AttributeAccessor;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has identifier => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{identifier} = delete $args{ Identifier };

  $class->$orig( %args );
};

1;
__END__

=head1 NOTHING TO SEE HERE

This file is part of L<Locale::Fluent>. See its documentation for more
information.

=cut

