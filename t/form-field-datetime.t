#!/usr/bin/perl -w

use strict;

use Test::More tests => 37;

BEGIN 
{
  use_ok('Rose::DateTime::Util');
  use_ok('Rose::HTML::Form::Field::DateTime');
}

my $field = Rose::HTML::Form::Field::DateTime->new(
  label       => 'Date', 
  description => 'Some Date',
  name        => 'date',
  size        => 30,
  value       => '12/25/1984',
  default     => '1/1/2000');

ok(ref $field eq 'Rose::HTML::Form::Field::DateTime', 'new()');

is($field->html_field, '<input name="date" size="30" type="text" value="1984-12-25 12:00:00 AM">', 'html_field() 1');
is($field->xhtml_field, '<input name="date" size="30" type="text" value="1984-12-25 12:00:00 AM" />', 'xhtml_field() 1');

my $date = $field->internal_value;

is(ref $date, 'DateTime', 'internal_value() 1');
is($date->strftime('%m/%d/%Y %H:%M:%S'), '12/25/1984 00:00:00', 'internal_value() 2');
is($field->input_value, '12/25/1984', 'input_value() 1');
is($field->output_value, '1984-12-25 12:00:00 AM', 'output_value() 1');

$field->clear;

is($field->html_field, '<input name="date" size="30" type="text" value="">', 'html_field() 2');
is($field->xhtml_field, '<input name="date" size="30" type="text" value="" />', 'xhtml_field() 2');

is($field->internal_value, undef, 'internal_value() 3');
is($field->input_value, undef, 'input_value() 2');
is($field->output_value, undef, 'output_value() 2');

$field->reset;

is($field->html_field, '<input name="date" size="30" type="text" value="2000-01-01 12:00:00 AM">', 'html_field() 3');
is($field->xhtml_field, '<input name="date" size="30" type="text" value="2000-01-01 12:00:00 AM" />', 'xhtml_field() 3');

$date = $field->internal_value;

is(ref $date, 'DateTime', 'internal_value() 4');
is($date->strftime('%m/%d/%Y %H:%M:%S'), '01/01/2000 00:00:00', 'internal_value() 5');
is($field->input_value, '1/1/2000', 'input_value() 3');
is($field->output_value, '2000-01-01 12:00:00 AM', 'output_value() 3');

# Testing default size value
$field->delete_html_attr('size');

is($field->html_field, '<input name="date" size="25" type="text" value="2000-01-01 12:00:00 AM">', 'html_field() 4');
is($field->xhtml_field, '<input name="date" size="25" type="text" value="2000-01-01 12:00:00 AM" />', 'xhtml_field() 4');

is($field->validate, 1, 'validate() 1');

$field->input_value('foo');

is($field->internal_value, undef, 'internal_value() 6');
is($field->input_value, 'foo', 'input_value() 4');
is($field->output_value, 'foo', 'output_value() 4');

is($field->validate, 0, 'validate() 2');

$field->output_filter(sub { uc });

is($field->internal_value, undef, 'internal_value() 7');
is($field->input_value, 'foo', 'input_value() 5');
is($field->output_value, 'FOO', 'output_value() 5');

$field->output_filter(sub { lc });
$field->input_filter(sub { s/^-//; $_ });

$field->input_value('-2/2/2003');

is($field->validate, 1, 'validate() 3');

$date = $field->internal_value;

is(ref $date, 'DateTime', 'internal_value() 4');
is($date->strftime('%m/%d/%Y %H:%M:%S'), '02/02/2003 00:00:00', 'internal_value() 8');

is($field->input_value, '-2/2/2003', 'input_value() 6');
is($field->output_value, '2003-02-02 12:00:00 am', 'output_value() 6');

$field->time_zone('UTC');

$field->input_value('3/4/2005 12:34:56');

my $d1 = Rose::DateTime::Util::parse_date('3/4/2005 12:34:56', 'UTC');
my $d2 = $field->internal_value;

is(ref $d2, 'DateTime', 'internal_value() 9');

ok($d1 == $d2, 'time_zone() 1');
