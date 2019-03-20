package Protocol::PostgreSQL::Backend::EmptyQueryResponse;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::EmptyQueryResponse

=head1 DESCRIPTION

=cut

sub type { 'empty_query_response' }

sub parse {
    my ($self, $msg) = @_;
    if(@{$self->{pending_execute}}) {
        my $last = shift @{$self->{pending_execute}};
        $self->debug("Finished command for $last");
    }
#    $self->bus->invoke_event('empty_query');
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

