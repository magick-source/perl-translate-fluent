package Locale::Fluent::Parser;

use parent qw'Exporter';

our @EXPORT_OK = qw(
  parse_file
);

use Regexp::Grammars;

my $fluent_parser = qr<
  <nocontext:>
  <[Resource]>*

  <token: ws>
    [\x{20}\t]

  <token: Resource>
    <Entry> | <blank_block> | <CommentLine> | <Junk>

  <token: Entry>
      <Message> <.line_end>
    | <Term> <.line_end>

  <token: Message>
    <Identifier> <.ws>* = <.ws>* ((<Pattern> <[Attribute]>*)|<[Attribute]>+)

  <token: Term>
    - <Identifier> <.ws>* = <.ws>* <Pattern> <[Attribute]>*

  <token: CommentLine>
   <comment_type> <.ws>* <comment> <.line_end>

  <token: comment>
    (<.comment_char>)*

  <token: Junk>
    <a_junk_line> <[next_junk_line]>*

  <token: a_junk_line>
    <.not_new_line> <.line_end>

  <token: next_junk_line>
    <.ws>* <.junk_starter> <.not_new_line> <.line_end>

  <token: not_new_line>
    [^\n]*

  <token: junk_starter>
    [^\#\-a-zA-Z\n\s\.]+

  <token: Pattern>
    <[PatternElement]>+

  <token: PatternElement>
    <inline_text> | <block_text> | <inline_placeable> | <block_placeable>


  <token: inline_text>
    <.non_special>+

  <token: block_text>
    <.blank_block> <.ws>+ <indented_char> <inline_text>?

  <token: inline_placeable>
    \{ <.blank>* ( <SelectExpression> | <InlineExpression> ) <.blank>* \}

  <token: block_placeable>
    <blank_block> <.ws>+ <inline_placeable>

  <token: InlineExpression>
      <StringLiteral>
    | <NumberLiteral>
    | <FunctionReference>
    | <MessageReference>
    | <TermReference>
    | <VariableReference>
    | <inline_placeable>

  <token: SelectExpression>
    <InlineExpression> <.blank>? \-\> <.blank>? <variant_list>

  <token: variant_list>
    <[variant]>* <DefaultVariant> <[variant]>* <line_end>

  <token: variant>
    <.line_end> <.blank>? <VariantKey> <.ws>? <Pattern>

  <token: DefaultVariant>
    <.line_end> <.blank>? \* <VariantKey> <.ws>? <Pattern>

  <token: VariantKey>
    \[ <.blank>? ( <NumberLiteral> | <Identifier> ) <.blank>? \]

  <token: StringLiteral>
    \" <.quoted_char>* \"

  <token: NumberLiteral>
    \-? [0-9]+ (\. [0-9]+)?


  <token: FunctionReference>
    <Identifier> <CallArguments>

  <token: CallArguments>
    <.blank>? \( <.blank>? <argument_list> <.blank>? \)

  <token: argument_list>
    (<Argument> <.blank>? , <.blank>? )* <Argument>?

  <token: Argument>
    <NamedArgument> | <InlineExpression>

  <token: NamedArgument>
    <Identifier> <.blank>? : <.blank>? (<StringLiteral>|<NumberLiteral>)

  <token: MessageReference>
    <Identifier> <AttributeAccessor>?

  <token: TermReference>
    \- <Identifier> <AttributeAccessor>? <CallArguments>?

  <token: VariableReference>
    \$ <Identifier>

  <token: AttributeAccessor>
    \. <Identifier>

  <token:Attribute>
    <.line_end> <.ws>* \.<Identifier> <.ws>* = <.ws>* <Pattern>

  <token: blank_block>
    (<.ws>* <.line_end>)+

  <token: quoted_char>
    [^\"\\] | \\[\"\\] | \\u[0-9a-fA-F]{4} | \\u[0-9a-fA-F]{6}

  <token: indented_char>
    [^\n\{\}\[\*\.\s\#]

  <token: comment_char>
    [^\n]

  <token: Identifier>
    [a-zA-Z][a-zA-Z0-9_-]*
  
  <token: comment_type>
    \#\#\# | \#\# | \#

  <token: non_special>
    [^\n\{\}\"]

  <token: line_end>
    \n | \z

  <token: blank>
    (<.ws> | <.line_end>)+

>sx;

print $fluent_parser,"\n\n";

sub parse_file {
  my ($fname) = @_;

  local $/ = undef;

  open my $fh, '<', $fname or die "Error opening file '$fname': $!\n";

  print STDERR "Going to read it\n";
  my $text = <$fh>;

  print STDERR "Going to parse it\n";

  if ( $text =~ $fluent_parser ) {
    use Data::Dumper;
    print Dumper( \%/ );
  }
}
