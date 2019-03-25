package Protocol::Database::PostgreSQL::Notification;

use strict;
use warnings;

# VERSION

use Adapter::Async::Model {
	channel => 'string',
	pid     => 'int',
	payload => 'string'
};

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2019. Licensed under the same terms as Perl itself.

