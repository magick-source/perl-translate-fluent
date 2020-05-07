package Locale::Fluent::Elements::TermReference;

use Moo;
extends 'Locale::Fluent::Elements::Base';

has [qw(
      identifier
      attribute_accessor
      call_arguments
    )] => (
  is  => 'ro',
  default => sub { undef },
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{identifier}         = delete $args{ Identifier };
  $args{attribute_accessor} = delete $args{ AttributeAccessor };
  $args{call_arguments}     = delete $args{ CallArguments };

  $class->$orig( %args );
};

sub translate {
  my ($self, $variables) = @_;

  my $res = $variables->{__resourceset}->get_term( $self->identifier );
  return unless $res;

  if ($self->attribute_accessor) {
    $res = $res->get_attribute_resource(
                $self->attribute_accessor->identifier
              );
  }

  return unless $res;

  my $vars = $self->call_arguments
    ? { %{ $self->call_arguments->to_variables }, 
           __resourceset => $variables->{__resourceset}
      }
    : $variables;

  return $res->translate( $vars );
}

1;
