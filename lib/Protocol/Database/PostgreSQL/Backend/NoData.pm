package Protocol::PostgreSQL::Backend::NoData;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::NoData

=head1 DESCRIPTION

=cut

sub type { 'no_data' }

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size) = unpack('C1N1', $msg);
#    $self->bus->invoke_event('no_data');
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

