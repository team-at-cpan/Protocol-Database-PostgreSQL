package Protocol::PostgreSQL::Backend::CopyDone;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::CopyDone

=head1 DESCRIPTION

=cut

sub type { 'copy_done' }

sub parse {
    my ($self, $msg) = @_;
    ...
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

