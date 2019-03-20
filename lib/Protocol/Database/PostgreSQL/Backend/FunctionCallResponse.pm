package Protocol::PostgreSQL::Backend::FunctionCallResponse;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::FunctionCallResponse

=head1 DESCRIPTION

=cut

sub type { 'function_call_response' }

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size, my $len) = unpack('C1N1N1', $msg);
    substr $msg, 0, 9, '';
    my $data = ($len == 0xFFFFFFFF) ? undef : substr $msg, 0, $len;
#    $self->bus->invoke_event('function_call_response', data => $data);
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

