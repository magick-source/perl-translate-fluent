package Locale::Fluent::Elements::PatternElement;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(inline_text block_text inline_placeable block_placeable)] => (
  is  => 'ro',
  default => sub { undef },
);


1;
