package Protocol::Database::PostgreSQL::Backend::ParameterStatus;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::ParameterStatus

=head1 DESCRIPTION

=cut

sub key { shift->{key} }
sub value { shift->{value} }

sub new_from_message {
    my ($class, $msg) = @_;

    # Extract size then reset pointer to start of parameters
    my (undef, undef, $k, $v) = unpack('C1N1Z*Z*', $msg);

    return $class->new(
        key => $k,
        value => $v,
    );
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

