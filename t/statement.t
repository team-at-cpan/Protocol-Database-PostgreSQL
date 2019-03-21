use strict;
use warnings;

use Test::More;
use Test::Fatal;
use Test::Warnings;

use Protocol::Database::PostgreSQL::Statement;

subtest '->new validation' => sub {
	like(exception {
		Protocol::Database::PostgreSQL::Statement->new
	}, qr/No DBH/, q{complain when there's no $dbh});
	like(exception {
		Protocol::Database::PostgreSQL::Statement->new(dbh => 0);
	}, qr/No DBH/, q{complain when $dbh is false});
	like(exception {
		Protocol::Database::PostgreSQL::Statement->new(dbh => '');
	}, qr/No DBH/, q{complain when $dbh is empty});
	like(exception {
		Protocol::Database::PostgreSQL::Statement->new(dbh => undef);
	}, qr/No DBH/, q{complain when $dbh is undef});

	like(exception {
		Protocol::Database::PostgreSQL::Statement->new(dbh => 1, sql => undef);
	}, qr/No SQL/, q{complain when {sql} is undef});
	done_testing;
};

done_testing;

