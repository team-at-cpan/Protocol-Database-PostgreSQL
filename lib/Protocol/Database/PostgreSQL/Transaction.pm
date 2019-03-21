package Protocol::Database::PostgreSQL::Transaction;

use strict;
use warnings;

use constant {
	PENDING => 0,
	COMMITTED => 1,
	ROLLBACK => 2,
};

sub new {
	my $class = shift;
	bless {
		state => PENDING,
		@_,
	}, $class
}

sub is_active { $_[0]->{state} == PENDING }

sub commit {
	my ($self) = @_;
	die 'bad state' unless $self->is_active;
}

sub rollback {
	my ($self) = @_;
	die 'bad state' unless $self->is_active;
}

sub DESTROY {
	my ($self) = @_;
	# not much we can do if we're already shutting down
	return if ${^GLOBAL_PHASE} eq 'DESTRUCT';
	$self->rollback if $self->is_active
}

1;

