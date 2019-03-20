package Protocol::PostgreSQL::Backend::RowDescription;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::RowDescription

=head1 DESCRIPTION

=cut

use Protocol::PostgreSQL::RowDescription;
use Protocol::PostgreSQL::FieldDescription;

sub parse {
    my ($self, $msg) = @_;
    my (undef, undef, $count) = unpack('C1N1n1', $msg);
    my $row = Protocol::PostgreSQL::RowDescription->new;
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
        $self->debug($_ . ' => ' . $data{$_}) for sort keys %data;
        my $field = Protocol::PostgreSQL::FieldDescription->new(%data);
        $row->add_field($field);
        substr $msg, 0, 19 + length($name), '';
    }
    $self->row_description($row);
    if(my $last = shift @{$self->{pending_describe}}) {
        $last->row_description($row);
    }
#    $self->bus->invoke_event('row_description', description => $row);
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

