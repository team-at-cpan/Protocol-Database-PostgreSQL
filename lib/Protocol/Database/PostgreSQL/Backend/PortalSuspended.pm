package Protocol::PostgreSQL::Backend::PortalSuspended;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::PortalSuspended

=head1 DESCRIPTION

=cut

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size) = unpack('C1N1', $msg);
    if(@{$self->{pending_execute}}) {
        my $last = shift @{$self->{pending_execute}};
        $self->debug("Suspended portal for $last");
    }
#    $self->bus->invoke_event('portal_suspended');
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

