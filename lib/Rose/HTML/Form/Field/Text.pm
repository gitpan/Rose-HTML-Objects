package Rose::HTML::Form::Field::Text;

use strict;

use Rose::HTML::Form::Field::Input;
our @ISA = qw(Rose::HTML::Form::Field::Input);

our $VERSION = '0.011';

__PACKAGE__->delete_valid_html_attrs(qw(ismap usemap alt src));

__PACKAGE__->add_required_html_attrs(
{
  type  => 'text',
  name  => '',
  size  => 15,
  value => '',
});

sub html_field
{
  my($self) = shift;
  $self->html_attr(value => $self->output_value);
  return $self->SUPER::html_field(@_);
}

sub xhtml_field
{
  my($self) = shift;
  $self->html_attr(value => $self->output_value);
  return $self->SUPER::xhtml_field(@_);
}

1;

__END__

=head1 NAME

Rose::HTML::Form::Field::Text - Object representation of a text field
in an HTML form.

=head1 SYNOPSIS

    $field =
      Rose::HTML::Form::Field::Text->new(
        label     => 'Your Age', 
        name      => 'age',
        size      => 2,
        maxlength => 3);

    $age = $field->internal_value;

    print $field->html;

    ...

=head1 DESCRIPTION

C<Rose::HTML::Form::Field::Text> is an object representation of a text field
in an HTML form.

This class inherits from, and follows the conventions of,
C<Rose::HTML::Form::Field>. Inherited methods that are not overridden will not
be documented a second time here.  See the C<Rose::HTML::Form::Field>
documentation for more information.

=head1 HTML ATTRIBUTES

Valid attributes:

    accept
    accesskey
    checked
    class
    dir
    disabled
    id
    lang
    maxlength
    name
    onblur
    onchange
    onclick
    ondblclick
    onfocus
    onkeydown
    onkeypress
    onkeyup
    onmousedown
    onmousemove
    onmouseout
    onmouseover
    onmouseup
    onselect
    readonly
    size
    style
    tabindex
    title
    type
    value
    xml:lang

Required attributes (default values in parentheses):

    name
    size  (15)
    type  (text)
    value

Boolean attributes:

    checked
    disabled
    readonly

=head1 CONSTRUCTOR

=over 4

=item B<new PARAMS>

Constructs a new C<Rose::HTML::Form::Field::Text> object based on PARAMS,
where PARAMS are name/value pairs.  Any object method is a valid parameter
name.

=back

=head1 AUTHOR

John C. Siracusa (siracusa@mindspring.com)

=head1 COPYRIGHT

Copyright (c) 2004 by John C. Siracusa.  All rights reserved.  This program is
free software; you can redistribute it and/or modify it under the same terms
as Perl itself.
