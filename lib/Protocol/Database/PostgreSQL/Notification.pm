package Protocol::Database::PostgreSQL::Notification;

use strict;
use warnings;

use Adapter::Async::Model {
	channel => 'string',
	pid => 'int',
	payload => 'string'
};

1;

