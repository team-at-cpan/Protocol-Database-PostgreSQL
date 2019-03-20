package Protocol::PostgreSQL::Row;

use strict;
use warnings;

use Adapter::Async::Model {
	description => 'Protocol::PostgreSQL::RowDescription',
};

sub fields { @{shift->{fields}} }

1;

