package Protocol::Database::PostgreSQL::RowDescription;

use strict;
use warnings;

=head1 NAME

Protocol::Database::PostgreSQL::RowDescription - row definitions

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

use Protocol::Database::PostgreSQL::FieldDescription;

=head1 METHODS

=cut

sub new { bless {}, shift }

=head2 field_count

Returns the current field count.

=cut

sub field_count { shift->{field_count} }

=head2 add_field

Add a new field to the list.

=cut

sub add_field {
	my $self = shift;
	my $field = shift;
	++$self->{field_count};
	push @{$self->{field}}, $field;
	return $self;
}

sub field_index {
	my $self = shift;
	my $idx = shift;
	return $self->{field}->[$idx];
}

1;

__END__

=head1 SEE ALSO

L<DBD::Pg>, which uses the official library and has had far more testing.

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2015. Licensed under the same terms as Perl itself.

