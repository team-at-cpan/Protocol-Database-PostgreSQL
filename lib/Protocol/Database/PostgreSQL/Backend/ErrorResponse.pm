package Protocol::PostgreSQL::Backend::ErrorResponse;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::ErrorResponse

=head1 DESCRIPTION

=cut

use Log::Any qw($log);

sub type { 'error_response' }

sub new_from_message {
    my ($class, $msg) = @_;
    (undef, my $size) = unpack('C1N1', $msg);
    substr $msg, 0, 5, '';
    my %notice;
    FIELD:
    while(length($msg)) {
        my ($code, $str) = unpack('A1Z*', $msg);
        last FIELD unless $code && $code ne "\0";

        die "Unknown NOTICE code [$code]" unless exists $Protocol::PostgreSQL::NOTICE_CODE{$code};
        $notice{$Protocol::PostgreSQL::NOTICE_CODE{$code}} = $str;
        substr $msg, 0, 2+length($str), '';
    }
    $log->errorf("Error was %s", \%notice);
    return $class->new(
        %notice
    );
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

