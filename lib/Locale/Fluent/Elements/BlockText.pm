package Locale::Fluent::Elements::BlockText;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has text => (
  is  => 'ro',
  default => sub { undef },
);


around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  my $text = ($args{indented_char}//'').($args{inline_text}//'');

  $class->$orig( text => $text );
};

sub translate {
  return "\n".$_[0]->text;
}

1;
