package Protocol::Database::PostgreSQL::Backend::CloseComplete;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::CloseComplete - an authentication request message

=head1 DESCRIPTION

=cut

sub type { 'close_complete' }

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size) = unpack('C1N1', $msg);

    # Handler could be undef - we always push something to keep things symmetrical
    if(my $handler = shift @{$self->{pending_close}}) {
        $handler->($self);
    }
#    $self->bus->invoke_event('close_complete');
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

