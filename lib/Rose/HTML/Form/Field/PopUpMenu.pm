package Rose::HTML::Form::Field::PopUpMenu;

use strict;

use Rose::HTML::Form::Field::SelectBox;
our @ISA = qw(Rose::HTML::Form::Field::SelectBox);

our $VERSION = '0.01';

__PACKAGE__->required_html_attr_value(size => 1);
__PACKAGE__->delete_valid_html_attr('multiple');

1;

__END__

=head1 NAME

Rose::HTML::Form::Field::PopUpMenu - Object representation of a pop-up menu
in an HTML form.

=head1 SYNOPSIS

    $field = Rose::HTML::Form::Field::PopUpMenu->new(name => 'fruits');

    $field->options(apple  => 'Apple',
                    orange => 'Orange',
                    grape  => 'Grape');

    print $field->label('apple'); # 'Apple'

    $field->input_value('orange');

    print $field->internal_value; # 'orange'

    print $field->html;

    ...

=head1 DESCRIPTION

C<Rose::HTML::Form::Field::PopUpMenu> is an object representation of a pop-up
menu field in an HTML form.

This class inherits from, and follows the conventions of,
C<Rose::HTML::Form::Field>. Inherited methods that are not overridden will not
be documented a second time here.  See the C<Rose::HTML::Form::Field>
documentation for more information.

=head1 HTML ATTRIBUTES

Valid attributes:

    accesskey
    class
    dir
    id
    lang
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
    size
    style
    tabindex
    title
    value
    xml:lang

Required attributes:

    name
    size

=head1 CONSTRUCTOR

=over 4

=item B<new PARAMS>

Constructs a new C<Rose::HTML::Form::Field::PopUpMenu> object based on PARAMS,
where PARAMS are name/value pairs.  Any object method is a valid parameter
name.

=back

=head1 OBJECT METHODS

=over 4

=item B<add_option OPTION>

Convenience alias for C<add_options()>.

=item B<add_options OPTIONS>

Adds options to the pop-up menu.  OPTIONS may be a reference to a hash of
value/label pairs, a reference to an array of values, or a list of objects
that are of, or inherit from, the classes C<Rose::HTML::Form::Field::Option>
or C<Rose::HTML::Form::Field::OptionGroup>. Passing an odd number of items in
the value/label argument list causes a fatal error. Options passed as a hash
reference are sorted by value according to the default behavior of Perl's
built-in C<sort()> function.  Options are added to the end of the existing
list of options.

=item B<has_value VALUE>

Returns true if VALUE is selected in the pop-up menu, false otherwise.

=item B<label VALUE [, LABEL]>

Get or set the label for a single value.  The label for VALUE is returned.
If the value exists, but has no label, then the value itself is returned.
If the value does not exist, then undef is returned.

=item B<labels [LABELS]>

Get or set the labels for all values.  If LABELS is a reference to a hash or a
list of value/label pairs, then LABELS replaces all existing labels.  Passing an
odd number of items in the list version of LABELS causes a fatal error.

Returns a hash of value/label pairs in list context, or a reference to a hash
in scalar context.

=item B<option VALUE>

Returns the first option (according to the order that they are returned from
C<options()>) whose "value" HTML attribute is VALUE, or undef if no such
option exists.

=item B<options OPTIONS>

Get or set the full list of options in the pop-up menu.  OPTIONS may be a
reference to a hash of value/label pairs, a reference to an array of values,
or a list of objects that are of, or inherit from, the classes
C<Rose::HTML::Form::Field::Option> or C<Rose::HTML::Form::Field::OptionGroup>.
Passing an odd number of items in the value/label argument list causes a fatal
error. Options passed as a hash reference are sorted by value according to the
default behavior of Perl's built-in C<sort()> function.

To set an ordered list of option values along with labels in the constructor,
use both the C<options()> and C<labels()> methods in the correct order. 
Example:

    $field = 
      Rose::HTML::Form::Field::PopUpMenu->new(
        name    => 'fruits',
        options => [ 'apple', 'pear' ],
        labels  => { apple => 'Apple', pear => 'Pear' });

Remember that methods are called in the order that they appear in the
constructor arguments (see the C<Rose::Object> documentation), so C<options()>
will be called before C<labels()> in the example above.  This is important; it
will not work in the opposite order.

Returns a list of the pop-up menu's C<Rose::HTML::Form::Field::Option> and/or
C<Rose::HTML::Form::Field::OptionGroup> objects in list context, or a
reference to an array of the same in scalar context. These are the actual
objects used in the field. Modifying them will modify the field itself.

=item B<value [VALUE]>

Simply calls C<input_value()>, passing all arguments.

=item B<value_label>

Returns the label of the first selected value (according to the order that
they are returned by C<internal_value()>), or the value itself if it has no
label. If no value is selected, undef is returned.

=back

=head1 AUTHOR

John C. Siracusa (siracusa@mindspring.com)