package Rose::HTML::Form::Field::DateTime::Split;

use strict;

use Rose::HTML::Form::Field::DateTime;
use Rose::HTML::Form::Field::Compound;
our @ISA = qw(Rose::HTML::Form::Field::Compound Rose::HTML::Form::Field::DateTime);

our $VERSION = '0.01';

# Multiple inheritence never quite works out the way I want it to...
Rose::HTML::Form::Field::DateTime->import_methods
(
  'inflate_value',
  'validate',
);

1;
