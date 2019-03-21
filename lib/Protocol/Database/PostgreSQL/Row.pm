package Protocol::Database::PostgreSQL::Row;

use strict;
use warnings;

use Adapter::Async::Model {
	description => 'Protocol::Database::PostgreSQL::RowDescription',
};

sub fields { @{shift->{fields}} }

1;

