package Protocol::PostgreSQL::Backend::CopyInResponse;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::CopyInResponse

=head1 DESCRIPTION

=cut

sub type { 'copy_in_response' }

sub parse {
    my ($self, $msg) = @_;
    (undef, undef, my $type, my $count) = unpack('C1N1C1n1', $msg);
    substr $msg, 0, 8, '';
    my @formats;
    for (1..$count) {
        push @formats, unpack('n1', $msg);
        substr $msg, 0, 2, '';
    }
#    $self->bus->invoke_event('copy_in_response', count => $count, columns => \@formats);
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

