package Locale::Fluent::Elements::PatternElement;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(inline_text block_text inline_placeable block_placeable)] => (
  is  => 'ro',
  default => sub { undef },
);


1;
__END__

=head1 NOTHING TO SEE HERE

This file is part of L<Locale::Fluent>. See its documentation for more
information.

=cut

