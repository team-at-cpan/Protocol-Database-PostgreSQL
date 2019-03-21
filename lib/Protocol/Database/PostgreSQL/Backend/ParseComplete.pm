package Protocol::Database::PostgreSQL::Backend::ParseComplete;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::ParseComplete

=head1 DESCRIPTION

=cut

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size) = unpack('C1N1', $msg);
    $self->active_statement->parse_complete if $self->active_statement;
#    $self->bus->invoke_event('parse_complete');
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

