package Protocol::Database::PostgreSQL::Backend::RowDescription;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::Database::PostgreSQL::Backend);

=head1 NAME

Protocol::Database::PostgreSQL::Backend::RowDescription

=head1 DESCRIPTION

=cut

use Protocol::Database::PostgreSQL::RowDescription;
use Protocol::Database::PostgreSQL::FieldDescription;

use Log::Any qw($log);

sub description { shift->{description} }

sub new_from_message {
    my ($class, $msg) = @_;
    my (undef, undef, $count) = unpack('C1N1n1', $msg);
    my $row = Protocol::Database::PostgreSQL::RowDescription->new;
    substr $msg, 0, 7, '';
    foreach my $id (0..$count-1) {
        my ($name, $table_id, $field_id, $data_type, $data_size, $type_modifier, $format_code) = unpack('Z*N1n1N1n1N1n1', $msg);
        my %data = (
            name          => $name,
            table_id      => $table_id,
            field_id      => $field_id,
            data_type     => $data_type,
            data_size     => $data_size,
            type_modifier => $type_modifier,
            format_code   => $format_code
        );
        if($log->is_debug) {
            $log->tracef('%s => %s', $_, $data{$_}) for sort keys %data;
        }
        $row->add_field(Protocol::Database::PostgreSQL::FieldDescription->new(%data));
        substr $msg, 0, 19 + length($name), '';
    }
    return $class->new(
        description => $row
    );
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

