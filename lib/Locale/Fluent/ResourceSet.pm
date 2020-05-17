package Locale::Fluent::ResourceSet;

use Moo;

has resources => (
  is  => 'rw',
  default => sub { {} },
);

sub add_resource {
  my ($self, $resource) = @_;

  $self->resources->{ $resource->identifier } = $resource;

}

sub translate {
  my ($self, $res_id, $variables) = @_;

  my $res = $self->resources->{ $res_id };

  return unless $res and $res->isa("Locale::Fluent::Elements::Message");

  return $res->translate( { %{$variables//{}}, __resourceset => $self} );
}

sub get_term {
  my ($self, $term_id) = @_;

  my $res = $self->resources->{ $term_id };
  return unless $res->isa("Locale::Fluent::Elements::Term");

  return $res;
}

sub get_message {
  my ($self, $message_id) = @_;

  my $res = $self->resources->{ $message_id };
  return unless $res->isa("Locale::Fluent::Elements::Message");

  return $res;
}

1;


