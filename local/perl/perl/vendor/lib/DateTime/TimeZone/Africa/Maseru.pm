# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/PHvstgqvGl/africa.  Olson data version 2012e
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Africa::Maseru;
{
  $DateTime::TimeZone::Africa::Maseru::VERSION = '1.48';
}

use strict;

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Africa::Maseru::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
60026393400,
DateTime::TimeZone::NEG_INFINITY,
60026400000,
6600,
0,
'LMT'
    ],
    [
60026393400,
61306156800,
60026400600,
61306164000,
7200,
0,
'SAST'
    ],
    [
61306156800,
61321878000,
61306167600,
61321888800,
10800,
1,
'SAST'
    ],
    [
61321878000,
DateTime::TimeZone::INFINITY,
61321885200,
DateTime::TimeZone::INFINITY,
7200,
0,
'SAST'
    ],
];

sub olson_version { '2012e' }

sub has_dst_changes { 1 }

sub _max_year { 2022 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;

