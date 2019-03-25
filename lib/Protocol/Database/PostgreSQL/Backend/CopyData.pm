package Protocol::Database::PostgreSQL::Backend::CopyData;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::CopyData

=head1 DESCRIPTION

=cut

sub type { 'copy_data' }

sub new_from_message {
    my ($self, $msg) = @_;
    ...
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

