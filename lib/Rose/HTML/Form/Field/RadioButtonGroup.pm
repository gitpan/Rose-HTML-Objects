package Rose::HTML::Form::Field::RadioButtonGroup;

use strict;

use Carp;

use Rose::HTML::Form::Field::RadioButton;

use Rose::HTML::Form::Field::Group;
use Rose::HTML::Form::Field::Group::OnOff;
our @ISA = qw(Rose::HTML::Form::Field::Group::OnOff);

our $VERSION = '0.01';

sub _item_class       { 'Rose::HTML::Form::Field::RadioButton' }
sub _item_name        { 'radio button' }
sub _item_name_plural { 'radio buttons' }

*radio_buttons = \&Rose::HTML::Form::Field::Group::items;

*radio_button      = \&Rose::HTML::Form::Field::Group::OnOff::item;
*add_radio_buttons = \&Rose::HTML::Form::Field::Group::add_items;
*add_radio_button  = \&add_radio_buttons;

sub html_table
{
  my($self, %args) = @_;

  $args{'cellpadding'} = 2  unless(exists $args{'cellpadding'});
  $args{'cellspacing'} = 0  unless(exists $args{'cellspacing'});
  $args{'tr'} = { valign => 'top' }  unless(exists $args{'tr'});
  $args{'td'} ||= {};

  $args{'table'}{'cellpadding'} = $args{'cellpadding'}
    unless((exists $args{'table'} && !defined $args{'table'}) || 
           exists $args{'table'}{'cellpadding'});

  $args{'table'}{'cellspacing'} = $args{'cellspacing'}
    unless((exists $args{'table'} && !defined $args{'table'}) ||
           exists $args{'table'}{'cellspacing'});

  return
    $self->SUPER::html_table(items       => scalar $self->radio_buttons,
                             format_item => \&Rose::HTML::Form::Field::Group::_html_item,
                             %args);
}

*xhtml_table = \&html_table;

1;

__END__

=head1 NAME

Rose::HTML::Form::Field::RadioButtonGroup - A group of radio buttons in an HTML form.

=head1 SYNOPSIS

    $field = 
      Rose::HTML::Form::Field::RadioButtonGroup->new(name => 'fruits');

    $field->radio_buttons(apple  => 'Apple',
                          orange => 'Orange',
                          grape  => 'Grape');

    print $field->label('apple'); # 'Apple'

    $field->input_value('orange');
    print $field->internal_value; # 'orange'

    print $field->html_table(columns => 2);

    ...

=head1 DESCRIPTION

C<Rose::HTML::Form::Field::RadioButtonGroup> is an object wrapper for a group
of radio buttons in an HTML form.

This class inherits from, and follows the conventions of,
C<Rose::HTML::Form::Field>. Inherited methods that are not overridden will not
be documented a second time here.  See the C<Rose::HTML::Form::Field>
documentation for more information.

=head1 HTML ATTRIBUTES

None.  This class is simply an aggregator of C<Rose::HTML::Form::Field::RadioButton>
objects.

=head1 CONSTRUCTOR

=over 4

=item B<new PARAMS>

Constructs a new C<Rose::HTML::Form::Field::RadioButtonGroup> object based on PARAMS,
where PARAMS are name/value pairs.  Any object method is a valid parameter
name.

=back

=head1 OBJECT METHODS

=over 4

=item B<add_radio_button OPTION>

Convenience alias for C<add_radio_buttons()>.

=item B<add_radio_buttons RADIO_BUTTONS>

Adds radio buttons to the radio button group.  RADIO_BUTTONS may be a
reference to a hash of value/label pairs, a reference to an array of values,
or a list of C<Rose::HTML::Form::Field::RadioButton> objects. Passing an odd
number of items in the value/label argument list causes a fatal error.
Radio button values and labels passed as a hash reference are sorted by value
according to the default behavior of Perl's built-in C<sort()> function. 
Radio buttons are added to the end of the existing list of radio buttons.

=item B<columns [COLS]>

Get or set the default number of columns to use in the output of the
C<html_table()> and C<xhtml_table()> methods.

=item B<has_value VALUE>

Returns true if the radio button whose value is VALUE is selected, false
otherwise.

=item B<html>

Returns the HTML for radio button group, which consists of the C<html()> for each
radio button object joined by C<html_linebreak()> if C<linebreak()> is true, or
single spaces if it is false.

=item B<html_linebreak [HTML]>

Get or set the HTML linebreak string.  The default is "E<lt>brE<gt>\n"

=item B<html_table [ARGS]>

Returns an HTML table containing the radio buttons.  The table is constructed
according ARGS, which are name/value pairs.  Valid arguments are:

=over 4

=item cellpadding

The value of the "table" tag's "cellpadding" HTML attribute.
Defaults to 2.

=item cellspacing

The value of the "table" tag's "cellspacing" HTML attribute.
Defaults to 0.

=item columns

The number of columns in the table.  Defaults to C<columns()>,
or 1 if C<columns()> is false.

=item format_item

The name of the method to call on each radio button object in order to
fill each table cell.  Defaults to "html"

=item rows

The number of rows in the table.  Defaults to C<rows()>,
or 1 if C<rows()> is false.

=item table

A reference to a hash of HTML attribute/value pairs to be used in
the "table" tag.  Some attribute values be overridden by the equivalent
standalone arguments (e.g., cellpadding and cellspacing).

=item td

A reference to a hash of HTML attribute/value pairs to be used in the "td"
tag, or an array of such hashes to be used in order for the table cells of
each row.  If the array contains fewer entries than the number of cells in
each row of the table, then the last entry is used for all of the remaining
cells in the row.  Defaults to a reference to an empty hash, C<{}>.

=item tr

A reference to a hash of HTML attribute/value pairs to be used in the "tr"
tag, or an array of such hashes to be used in order for the table rows.  If
the array contains fewer entries than the number of rows in the table, then
the last entry is used for all of the remaining rows.  Defaults to C<{ valign
=E<gt> 'top' }>.

=back

Specifying "rows" and "columns" values (either as ARGS or via C<rows()> and
C<columns()>) that are both greater than 1 leads to undefined behavior if
there are not exactly "rows x columns" radio buttons.  For predictable behavior,
set either rows or columns to a value greater than 1, but not both.

To remove HTML attributes that have default values, simply pass undef as the
value for those attributes.  Example:

    print $field->html_table();    

    # <table cellpadding="2" cellspacing="0">
    # <tr valign="top">
    # <td>...

    print $field->html_table(table => undef, tr => undef);

    # <table>
    # <tr>
    # <td>...

=item B<label VALUE [, LABEL]>

Get or set the label for the radio button whose value is VALUE.  The label for
that radio button is returned. If the radio button exists, but has no label,
then the value itself is returned. If the radio button does not exist, then
undef is returned.

=item B<labels [LABELS]>

Get or set the labels for all radio buttons.  If LABELS is a reference to a
hash or a list of value/label pairs, then LABELS replaces all existing labels.
Passing an odd number of items in the list version of LABELS causes a fatal
error.

Returns a hash of value/label pairs in list context, or a reference to a hash
in scalar context.

=item B<linebreak [BOOL]>

Get or set the flag that determines whether or not the string stored in
C<html_linebreak()> or C<xhtml_linebreak()> is used to separate radio buttons
in the output of C<html()> or C<xhtml()>, respectively.  Defaults to true.

=item B<radio_button VALUE>

Returns the first radio button (according to the order that they are returned
from C<radio_buttons()>) whose "value" HTML attribute is VALUE, or undef if no
such radio button exists.

=item B<radio_buttons RADIO_BUTTONS>

Get or set the full list of radio buttons in the group.  RADIO_BUTTONS may be a
reference to a hash of value/label pairs, a reference to an array of values,
or a list of C<Rose::HTML::Form::Field::RadioButton> objects. Passing an odd
number of items in the value/label argument list causes a fatal error.
Radio button values and labels passed as a hash reference are sorted by value
according to the default behavior of Perl's built-in C<sort()> function.

To set an ordered list of radio buttons along with labels in the constructor,
use both the C<radio_buttons()> and C<labels()> methods in the correct order. 
Example:

    $field = 
      Rose::HTML::Form::Field::RadioButtonGroup->new(
        name          => 'fruits',
        radio_buttons => [ 'apple', 'pear' ],
        labels        => { apple => 'Apple', pear => 'Pear' });

Remember that methods are called in the order that they appear in the
constructor arguments (see the C<Rose::Object> documentation), so
C<radio_buttons()> will be called before C<labels()> in the example above. 
This is important; it will not work in the opposite order.

Returns a list of the radio button group's C<Rose::HTML::Form::Field::RadioButton>
objects in list context, or a reference to an array of the same in scalar
context. These are the actual objects used in the field. Modifying them will
modify the field itself.

=item B<rows [ROWS]>

Get or set the default number of rows to use in the output of the
C<html_table()> and C<xhtml_table()> methods.

=item B<value [VALUE]>

Simply calls C<input_value()>, passing all arguments.

=item B<value_label>

Returns the label of the selected radio button, or the value itself if it has
no label. If no radio button is selected, undef is returned.

=item B<xhtml>

Returns the XHTML for radio button group, which consists of the C<xhtml()> for
each radio button object joined by C<xhtml_linebreak()> if C<linebreak()> is
true, or single spaces if it is false.

=item B<xhtml_linebreak [XHTML]>

Get or set the XHTML linebreak string.  The default is "E<lt>br /E<gt>\n"

=item B<xhtml_table>

Equivalent to C<html_table()>.

=back

=head1 AUTHOR

John C. Siracusa (siracusa@mindspring.com)