require 5.006;

use ExtUtils::MakeMaker;

WriteMakefile('NAME'         => 'Rose::HTML::Objects',
              'PMLIBDIRS'    => [ 'lib' ],
              'VERSION_FROM' => 'lib/Rose/HTML/Objects.pm',
              'PREREQ_PM' =>
              {
                'URI::Escape'    => 0,
                'Image::Size'    => 0,
                'Email::Valid'   => 0,
                'Scalar::Util'   => 0,
                'Rose::Object'   => 0,
                'Rose::DateTime' => 0,
              });
