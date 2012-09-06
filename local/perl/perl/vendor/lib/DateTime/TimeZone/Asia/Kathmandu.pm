# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/PHvstgqvGl/asia.  Olson data version 2012e
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Kathmandu;
{
  $DateTime::TimeZone::Asia::Kathmandu::VERSION = '1.48';
}

use strict;

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Kathmandu::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
60557739524,
DateTime::TimeZone::NEG_INFINITY,
60557760000,
20476,
0,
'LMT'
    ],
    [
60557739524,
62640585000,
60557759324,
62640604800,
19800,
0,
'IST'
    ],
    [
62640585000,
DateTime::TimeZone::INFINITY,
62640605700,
DateTime::TimeZone::INFINITY,
20700,
0,
'NPT'
    ],
];

sub olson_version { '2012e' }

sub has_dst_changes { 0 }

sub _max_year { 2022 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;

