use strict;
use warnings;

use Test::More tests => 1;                      # last test to print
use Protocol::Database::PostgreSQL::Client;

my @queue;
my $pg = new_ok('Protocol::Database::PostgreSQL::Client' => [
	debug => 0,
	on_send_request	=> sub {
		my ($self, $msg) = @_;
		push @queue, $msg;
	},
]);


