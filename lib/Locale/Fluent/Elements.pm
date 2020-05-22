package Locale::Fluent::Elements;

use Locale::Fluent::Elements::Message;
use Locale::Fluent::Elements::Pattern;
use Locale::Fluent::Elements::PatternElement;
use Locale::Fluent::Elements::InlinePlaceable;
use Locale::Fluent::Elements::InlineText;
use Locale::Fluent::Elements::InlineExpression;
use Locale::Fluent::Elements::BlockText;
use Locale::Fluent::Elements::BlockPlaceable;
use Locale::Fluent::Elements::FunctionReference;
use Locale::Fluent::Elements::VariableReference;
use Locale::Fluent::Elements::CallArguments;
use Locale::Fluent::Elements::ArgumentList;
use Locale::Fluent::Elements::Argument;
use Locale::Fluent::Elements::NamedArgument;
use Locale::Fluent::Elements::MessageReference;
use Locale::Fluent::Elements::TermReference;
use Locale::Fluent::Elements::AttributeAccessor;
use Locale::Fluent::Elements::StringLiteral;
use Locale::Fluent::Elements::Term;
use Locale::Fluent::Elements::SelectExpression;
use Locale::Fluent::Elements::Variant;
use Locale::Fluent::Elements::DefaultVariant;
use Locale::Fluent::Elements::Attribute;

sub create {
  my (undef, $type, $args) = @_;

  $type = "\u$type";
  $type =~ s/_(.)/\u$1/g;

  my $class = "Locale::Fluent::Elements::$type";

  my $res;
  eval {
    $res = $class->new( %$args );

    1;
  } or do {
    my ($err) = $@;
    print STDERR "err: $err\n"
      unless $err =~ m{Can't locate object method "new"};
    unless ($type eq 'Text') {
      print STDERR "FLT: Missing $class\n";
    }
  };

  return $res;
}

1;

__END__

=head1 NOTHING TO SEE HERE

this file is part of L<Locale::Fluent>. See its documentation for more information

=head2 create

this package implements a create method, but is not that interesting


=cut

