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
__END__

=head1 NOTHING TO SEE HERE

This file is part of L<Locale::Fluent>. See its documentation for more
information.

=head2 translate

this package implements a translate method, but is not that interesting

=cut

