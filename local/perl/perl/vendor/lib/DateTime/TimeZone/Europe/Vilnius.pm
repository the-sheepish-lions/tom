# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/PHvstgqvGl/europe.  Olson data version 2012e
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Europe::Vilnius;
{
  $DateTime::TimeZone::Europe::Vilnius::VERSION = '1.48';
}

use strict;

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Europe::Vilnius::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59295536324,
DateTime::TimeZone::NEG_INFINITY,
59295542400,
6076,
0,
'LMT'
    ],
    [
59295536324,
60463146960,
59295541364,
60463152000,
5040,
0,
'WMT'
    ],
    [
60463146960,
60550583064,
60463152696,
60550588800,
5736,
0,
'KMT'
    ],
    [
60550583064,
60574431600,
60550586664,
60574435200,
3600,
0,
'CET'
    ],
    [
60574431600,
60582117600,
60574438800,
60582124800,
7200,
0,
'EET'
    ],
    [
60582117600,
61207484400,
60582121200,
61207488000,
3600,
0,
'CET'
    ],
    [
61207484400,
61235557200,
61207495200,
61235568000,
10800,
0,
'MSK'
    ],
    [
61235557200,
61278426000,
61235564400,
61278433200,
7200,
1,
'CEST'
    ],
    [
61278426000,
61291126800,
61278429600,
61291130400,
3600,
0,
'CET'
    ],
    [
61291126800,
61307456400,
61291134000,
61307463600,
7200,
1,
'CEST'
    ],
    [
61307456400,
61323181200,
61307460000,
61323184800,
3600,
0,
'CET'
    ],
    [
61323181200,
61333538400,
61323188400,
61333545600,
7200,
1,
'CEST'
    ],
    [
61333538400,
62490603600,
61333549200,
62490614400,
10800,
0,
'MSK'
    ],
    [
62490603600,
62506411200,
62490618000,
62506425600,
14400,
1,
'MSD'
    ],
    [
62506411200,
62522139600,
62506422000,
62522150400,
10800,
0,
'MSK'
    ],
    [
62522139600,
62537947200,
62522154000,
62537961600,
14400,
1,
'MSD'
    ],
    [
62537947200,
62553675600,
62537958000,
62553686400,
10800,
0,
'MSK'
    ],
    [
62553675600,
62569483200,
62553690000,
62569497600,
14400,
1,
'MSD'
    ],
    [
62569483200,
62585298000,
62569494000,
62585308800,
10800,
0,
'MSK'
    ],
    [
62585298000,
62601030000,
62585312400,
62601044400,
14400,
1,
'MSD'
    ],
    [
62601030000,
62616754800,
62601040800,
62616765600,
10800,
0,
'MSK'
    ],
    [
62616754800,
62632479600,
62616769200,
62632494000,
14400,
1,
'MSD'
    ],
    [
62632479600,
62648204400,
62632490400,
62648215200,
10800,
0,
'MSK'
    ],
    [
62648204400,
62663929200,
62648218800,
62663943600,
14400,
1,
'MSD'
    ],
    [
62663929200,
62679654000,
62663940000,
62679664800,
10800,
0,
'MSK'
    ],
    [
62679654000,
62695378800,
62679668400,
62695393200,
14400,
1,
'MSD'
    ],
    [
62695378800,
62711103600,
62695389600,
62711114400,
10800,
0,
'MSK'
    ],
    [
62711103600,
62726828400,
62711118000,
62726842800,
14400,
1,
'MSD'
    ],
    [
62726828400,
62742553200,
62726839200,
62742564000,
10800,
0,
'MSK'
    ],
    [
62742553200,
62758278000,
62742567600,
62758292400,
14400,
1,
'MSD'
    ],
    [
62758278000,
62774002800,
62758288800,
62774013600,
10800,
0,
'MSK'
    ],
    [
62774002800,
62790332400,
62774017200,
62790346800,
14400,
1,
'MSD'
    ],
    [
62790332400,
62806057200,
62790343200,
62806068000,
10800,
0,
'MSK'
    ],
    [
62806057200,
62821785600,
62806068000,
62821796400,
10800,
1,
'EEST'
    ],
    [
62821785600,
62837510400,
62821792800,
62837517600,
7200,
0,
'EET'
    ],
    [
62837510400,
62853235200,
62837521200,
62853246000,
10800,
1,
'EEST'
    ],
    [
62853235200,
62868960000,
62853242400,
62868967200,
7200,
0,
'EET'
    ],
    [
62868960000,
62884684800,
62868970800,
62884695600,
10800,
1,
'EEST'
    ],
    [
62884684800,
62900409600,
62884692000,
62900416800,
7200,
0,
'EET'
    ],
    [
62900409600,
62916134400,
62900420400,
62916145200,
10800,
1,
'EEST'
    ],
    [
62916134400,
62931859200,
62916141600,
62931866400,
7200,
0,
'EET'
    ],
    [
62931859200,
62947584000,
62931870000,
62947594800,
10800,
1,
'EEST'
    ],
    [
62947584000,
62963913600,
62947591200,
62963920800,
7200,
0,
'EET'
    ],
    [
62963913600,
62982057600,
62963924400,
62982068400,
10800,
1,
'EEST'
    ],
    [
62982057600,
62995363200,
62982064800,
62995370400,
7200,
0,
'EET'
    ],
    [
62995363200,
63013507200,
62995374000,
63013518000,
10800,
1,
'EEST'
    ],
    [
63013507200,
63019288800,
63013514400,
63019296000,
7200,
0,
'EET'
    ],
    [
63019288800,
63026816400,
63019296000,
63026823600,
7200,
0,
'EET'
    ],
    [
63026816400,
63044960400,
63026823600,
63044967600,
7200,
1,
'CEST'
    ],
    [
63044960400,
63058266000,
63044964000,
63058269600,
3600,
0,
'CET'
    ],
    [
63058266000,
63077014800,
63058273200,
63077022000,
7200,
1,
'CEST'
    ],
    [
63077014800,
63177055200,
63077022000,
63177062400,
7200,
0,
'EET'
    ],
    [
63177055200,
63184669200,
63177062400,
63184676400,
7200,
0,
'EET'
    ],
    [
63184669200,
63202813200,
63184680000,
63202824000,
10800,
1,
'EEST'
    ],
    [
63202813200,
63216118800,
63202820400,
63216126000,
7200,
0,
'EET'
    ],
    [
63216118800,
63234867600,
63216129600,
63234878400,
10800,
1,
'EEST'
    ],
    [
63234867600,
63247568400,
63234874800,
63247575600,
7200,
0,
'EET'
    ],
    [
63247568400,
63266317200,
63247579200,
63266328000,
10800,
1,
'EEST'
    ],
    [
63266317200,
63279018000,
63266324400,
63279025200,
7200,
0,
'EET'
    ],
    [
63279018000,
63297766800,
63279028800,
63297777600,
10800,
1,
'EEST'
    ],
    [
63297766800,
63310467600,
63297774000,
63310474800,
7200,
0,
'EET'
    ],
    [
63310467600,
63329216400,
63310478400,
63329227200,
10800,
1,
'EEST'
    ],
    [
63329216400,
63342522000,
63329223600,
63342529200,
7200,
0,
'EET'
    ],
    [
63342522000,
63360666000,
63342532800,
63360676800,
10800,
1,
'EEST'
    ],
    [
63360666000,
63373971600,
63360673200,
63373978800,
7200,
0,
'EET'
    ],
    [
63373971600,
63392115600,
63373982400,
63392126400,
10800,
1,
'EEST'
    ],
    [
63392115600,
63405421200,
63392122800,
63405428400,
7200,
0,
'EET'
    ],
    [
63405421200,
63424170000,
63405432000,
63424180800,
10800,
1,
'EEST'
    ],
    [
63424170000,
63436870800,
63424177200,
63436878000,
7200,
0,
'EET'
    ],
    [
63436870800,
63455619600,
63436881600,
63455630400,
10800,
1,
'EEST'
    ],
    [
63455619600,
63468320400,
63455626800,
63468327600,
7200,
0,
'EET'
    ],
    [
63468320400,
63487069200,
63468331200,
63487080000,
10800,
1,
'EEST'
    ],
    [
63487069200,
63500374800,
63487076400,
63500382000,
7200,
0,
'EET'
    ],
    [
63500374800,
63518518800,
63500385600,
63518529600,
10800,
1,
'EEST'
    ],
    [
63518518800,
63531824400,
63518526000,
63531831600,
7200,
0,
'EET'
    ],
    [
63531824400,
63549968400,
63531835200,
63549979200,
10800,
1,
'EEST'
    ],
    [
63549968400,
63563274000,
63549975600,
63563281200,
7200,
0,
'EET'
    ],
    [
63563274000,
63581418000,
63563284800,
63581428800,
10800,
1,
'EEST'
    ],
    [
63581418000,
63594723600,
63581425200,
63594730800,
7200,
0,
'EET'
    ],
    [
63594723600,
63613472400,
63594734400,
63613483200,
10800,
1,
'EEST'
    ],
    [
63613472400,
63626173200,
63613479600,
63626180400,
7200,
0,
'EET'
    ],
    [
63626173200,
63644922000,
63626184000,
63644932800,
10800,
1,
'EEST'
    ],
    [
63644922000,
63657622800,
63644929200,
63657630000,
7200,
0,
'EET'
    ],
    [
63657622800,
63676371600,
63657633600,
63676382400,
10800,
1,
'EEST'
    ],
    [
63676371600,
63689677200,
63676378800,
63689684400,
7200,
0,
'EET'
    ],
    [
63689677200,
63707821200,
63689688000,
63707832000,
10800,
1,
'EEST'
    ],
    [
63707821200,
63721126800,
63707828400,
63721134000,
7200,
0,
'EET'
    ],
    [
63721126800,
63739270800,
63721137600,
63739281600,
10800,
1,
'EEST'
    ],
    [
63739270800,
63752576400,
63739278000,
63752583600,
7200,
0,
'EET'
    ],
    [
63752576400,
63771325200,
63752587200,
63771336000,
10800,
1,
'EEST'
    ],
    [
63771325200,
63784026000,
63771332400,
63784033200,
7200,
0,
'EET'
    ],
    [
63784026000,
63802774800,
63784036800,
63802785600,
10800,
1,
'EEST'
    ],
    [
63802774800,
63815475600,
63802782000,
63815482800,
7200,
0,
'EET'
    ],
    [
63815475600,
63834224400,
63815486400,
63834235200,
10800,
1,
'EEST'
    ],
];

sub olson_version { '2012e' }

sub has_dst_changes { 43 }

sub _max_year { 2022 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}

sub _last_offset { 7200 }

my $last_observance = bless( {
  'format' => 'EE%sT',
  'gmtoff' => '2:00',
  'local_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 731216,
    'local_rd_secs' => 0,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 731216,
    'utc_rd_secs' => 0,
    'utc_year' => 2004
  }, 'DateTime' ),
  'offset_from_std' => 0,
  'offset_from_utc' => 7200,
  'until' => [],
  'utc_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 731215,
    'local_rd_secs' => 79200,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 731215,
    'utc_rd_secs' => 79200,
    'utc_year' => 2003
  }, 'DateTime' )
}, 'DateTime::TimeZone::OlsonDB::Observance' )
;
sub _last_observance { $last_observance }

my $rules = [
  bless( {
    'at' => '1:00u',
    'from' => '1996',
    'in' => 'Oct',
    'letter' => '',
    'name' => 'EU',
    'offset_from_std' => 0,
    'on' => 'lastSun',
    'save' => '0',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' ),
  bless( {
    'at' => '1:00u',
    'from' => '1981',
    'in' => 'Mar',
    'letter' => 'S',
    'name' => 'EU',
    'offset_from_std' => 3600,
    'on' => 'lastSun',
    'save' => '1:00',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' )
]
;
sub _rules { $rules }


1;

