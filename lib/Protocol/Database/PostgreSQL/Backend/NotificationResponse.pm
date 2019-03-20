package Protocol::PostgreSQL::Backend::NotificationResponse;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::NotificationResponse

=head1 DESCRIPTION

=cut

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size, my $pid, my $channel, my $data) = unpack('C1N1N1Z*Z*', $msg);
#    $self->bus->invoke_event('notification', pid => $pid, channel => $channel, data => $data);
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

