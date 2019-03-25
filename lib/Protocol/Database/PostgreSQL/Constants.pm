package Protocol::Database::PostgreSQL::Constants;

use strict;
use warnings;

## VERSION

use Exporter qw(import export_to_level);

use List::Util qw(uniqstr);

use constant {
    SSL_DISABLE => 0,
    SSL_PREFER  => 1,
    SSL_REQUIRE => 2,
};

our %SSL_NAME_MAP = (
    disable => SSL_DISABLE,
    prefer  => SSL_PREFER,
    require => SSL_REQUIRE,
);

our %EXPORT_TAGS = (
    v1 => [qw(SSL_DISABLE SSL_PREFER SSL_REQUIRE)],
);
our @EXPORT_OK = uniqstr map { @$_ } values %EXPORT_TAGS;

1;

