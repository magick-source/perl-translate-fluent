package Locale::Fluent::ResourceGroup;

use Moo;

has sets => (
  is => 'rw',
  default => sub { {} },
);

has fallback_order  => (
  is => 'ro',
  default => sub { ['language' ] },
);

has default_language => (
  is      => 'ro',
  default => sub { 'en' },
);

sub __fallback_languages {
  my ($self, $lang, $default_lang) = @_;

  $default_lang ||= $self->default_language;

  my @langs = ($lang) if $lang;

  while ($lang and $lang=~m{\-}) {
    $lang =~ s{-\w+\z}{};
    push @langs, $lang;
  }
  unless ($lang eq $default_lang) {
    push @langs, $default_lang;
  }

  push @langs, 'dev' unless $default_lang eq 'dev';

  return @langs;
}

sub add_resource_set {
  my ($self, $resource_set, $context ) = @_;

  my @kv  = ();
  for my $fbo (@{ $self->fallback_order }) {
    my $fbok = $context->{ $fbo }
      || $fbo eq 'language' ? 'dev' : 'default';
    
    push @kv, $fbok;
  }

  my $key = join '>', @kv;

  my $reset = $self->sets->{ $key };
  if ( $reset ) {
    for my $k (keys %{ $resource_set->resources }) {
      $reset->add_resource( $resource_set->resource->{ $k } );
    }

  } else {
    $self->sets->{ $key } = $resource_set;

  }

  return;
}

sub translate {
  my ($self, $res_id, $variables, $context) = @_;

  $context = $variables->{__context}
    if !$context and $variables->{__context};

  my $_ctx;
  if (ref $context eq 'Locale::Fluent::ResourceGroup::Context') {
    $_ctx = $context;
    $context = $_ctx->context;
  }

  my $res = $self->_find_resource( $res_id, $context );

  return unless $res and $res->isa("Locale::Fluent::Elements::Message");

  $_ctx ||= Locale::Fluent::ResourceGroup::Context->new(
                context   => $context,
                resgroup  => $self,
              );
  
  return $res->translate({ %{$variables//{}}, __resourceset => $_ctx });
}

sub get_term {
  my ($self, $term_id, $context) = @_;

  my $term = $self->_find_resource( $term_id, $context );

  return unless $term->isa("Locale::Fluent::Elements::Term");

  return $term;
}

sub get_message {
  my ($self, $message_id, $context) = @_;

  my $res = $self->_find_resource( $message_id, $context );

  return unless $res->isa("Locale::Fluent::Elements::Message");

  return $res;
}

sub _find_resource {
  my ($self, $res_id, $context) = @_;

  my $lang = $context->{language} || $self->default_language;
  my %ctx = ();
  my @fborder = @{ $self->fallback_order };
  for my $fb ( @fborder ) {
    $ctx{ $fb } = $context->{ $fb }
                || (($fb eq 'language') ? $lang : 'default');
  }
  my %fbnext  = map { $fborder[$_-1] => $fborder[$_] } 1..$#fborder;
  my $fbnext  = ($fborder[0]);

  my $res;

  RESSET:
  while (!$res) {
    my $key = join '>', map { $ctx{$_} } @fborder;
#    use Data::Dumper;
#    print STDERR "checking '$key' => ", Dumper( \%ctx );
    
    if ( my $rset = $self->sets->{ $key }) {
      last RESSET if $res = $rset->resources->{ $res_id };
    }

    my $fbnext_default = $fbnext eq 'language' ? 'dev' : 'default';
    if ($ctx{ $fbnext } eq $fbnext_default) {
      do {
        last RESSET
          unless $fbnext{ $fbnext }; #no where else to look for

        $ctx{ $fbnext } = $context->{ $fbnext }
                        || $fbnext eq 'language' ? $lang : 'default';

        $fbnext = $fbnext{ $fbnext };

      } until $ctx{ $fbnext } ne $fbnext_default;

      $ctx{ $fbnext } = $fbnext eq 'language'
        ? ( $self->__fallback_languages( $ctx{language} ) )[1]
        : 'default';
      $fbnext = $fborder[0];

    } else {
      $ctx{ $fbnext } = $fbnext eq 'language'
        ? ( $self->__fallback_languages( $ctx{language} ) )[1]
        : 'default';
    }
  };

  return $res;
}

package Locale::Fluent::ResourceGroup::Context;

use Moo;

has context => (
  is => 'ro',
  default => sub { {} },
);

has resgroup => (
  is => 'ro',
);

sub get_term {
  my ($self, $term_id) = @_;

  return $self->resgroup->get_term( $term_id, $self->context );
}

sub get_message {
  my ($self, $message_id) = @_;

  return $self->resgroup->get_message( $message_id, $self->context );
}

1;
