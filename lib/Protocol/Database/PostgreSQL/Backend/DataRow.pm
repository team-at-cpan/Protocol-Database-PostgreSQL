package Protocol::PostgreSQL::Backend::DataRow;

use strict;
use warnings;

# VERSION

use parent qw(Protocol::PostgreSQL::Backend);

=head1 NAME

Protocol::PostgreSQL::Backend::DataRow

=head1 DESCRIPTION

=cut

sub type { 'data_row' }

sub parse {
    my ($self, $msg) = @_;
    my (undef, undef, $count) = unpack('C1N1n1', $msg);
    substr $msg, 0, 7, '';
    my @fields;
    # TODO Tidy this up
    my $sth = @{$self->{pending_execute}} ? $self->{pending_execute}[0] : $self->active_statement;
    my $desc = $sth ? $sth->row_description : $self->row_description;
    die "No description available?\n" unless $desc;
    foreach my $idx (0..$count-1) {
        my $field = $desc->field_index($idx);
        my ($size) = unpack('N1', $msg);
        substr $msg, 0, 4, '';
        my $data;
        my $null = ($size == 0xFFFFFFFF);
        unless($null) {
            $data = $field->parse_data($msg, $size);
            substr $msg, 0, $size, '';
        }
        push @fields, {
            null        => $null,
            description => $field,
            data        => $null ? undef : $data,
        }
    }
    $sth->data_row(\@fields) if $sth;
#    $self->bus->invoke_event('data_row', row => \@fields);
    return $self;
}

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2018. Licensed under the same terms as Perl itself.

