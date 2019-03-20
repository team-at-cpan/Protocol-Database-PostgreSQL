package Protocol::PostgreSQL::Backend::ReadyForQuery;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::ReadyForQuery

=head1 DESCRIPTION

=cut

use Log::Any qw($log);

sub state : method { shift->{state} }

sub new_from_message {
    my ($class, $msg) = @_;
    my (undef, undef, $state) = unpack('C1N1A1', $msg);
    $log->debugf("Backend state is %s", $state);
    return $class->new(
        state => $state
    );
    # $self->backend_state($Protocol::PostgreSQL::BACKEND_STATE{$state});
    # $self->debug("Pending bind: " . join(',', @{$self->{pending_bind} || []}) . ", execute: " . join(',', @{$self->{pending_execute} || []}));

#    return sub { $self->bus->invoke_event('ready_for_query'); $self }->() if @{$self->{pending_execute} || []};
    # $self->is_ready(1);
    # return $self->send_next_in_queue if $self->has_queued;
#    $self->bus->invoke_event('ready_for_query');
    #return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2019. Licensed under the same terms as Perl itself.

