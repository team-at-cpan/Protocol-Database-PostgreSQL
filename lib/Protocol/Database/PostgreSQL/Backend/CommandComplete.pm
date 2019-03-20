package Protocol::PostgreSQL::Backend::CommandComplete;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::CommandComplete - an authentication request message

=head1 DESCRIPTION

=cut

sub type { 'command_complete' }

sub parse {
    my ($self, $msg) = @_;
    my (undef, undef, $result) = unpack('C1N1Z*', $msg);
    if(@{$self->{pending_execute}}) {
        my $last = shift @{$self->{pending_execute}};
        $self->debug("Finished command for $last");
        $last->command_complete if $last;
    }
#    $self->bus->invoke_event('command_complete', result => $result);
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

