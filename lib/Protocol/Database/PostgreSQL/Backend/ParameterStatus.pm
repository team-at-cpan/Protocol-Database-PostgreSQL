package Protocol::Database::PostgreSQL::Backend::ParameterStatus;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::ParameterStatus

=head1 DESCRIPTION

=cut

sub new_from_message {
    my ($class, $msg) = @_;

    # Extract size then reset pointer to start of parameters
    (undef, my $size) = unpack('C1N1', $msg);
    substr $msg, 0, 5, '';

    my %status;
    # Series of key,value pairs
    PARAMETER:
    while(1) {
        my ($k, $v) = unpack('Z*Z*', $msg);
        last PARAMETER unless defined($k) && length($k);
        $status{$k} = $v;
        substr $msg, 0, length($k) + length($v) + 2, '';
    }
    return $class->new(
        %status
    );
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

