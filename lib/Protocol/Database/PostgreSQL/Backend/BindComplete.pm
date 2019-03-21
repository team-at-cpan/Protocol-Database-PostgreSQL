package Protocol::Database::PostgreSQL::Backend::BindComplete;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::BindComplete - an authentication request message

=head1 DESCRIPTION

=cut

sub type { 'bind_complete' }

sub parse {
    my ($self, $msg) = @_;
    (undef, my $size) = unpack('C1N1', $msg);
    if(my $sth = shift(@{$self->{pending_bind}})) {
        $self->debug("Pass over to statement $sth");
        $sth->bind_complete;
    }
#    $self->bus->invoke_event('bind_complete');
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

