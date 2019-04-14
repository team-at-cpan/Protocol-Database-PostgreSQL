package Protocol::Database::PostgreSQL::Error;

use strict;
use warnings;

use parent qw(Ryu::Exception);

sub code { shift->{code} }
sub file { shift->{file} }
sub line { shift->{line} }
sub message { shift->{message} }
sub position { shift->{position} }
sub routine { shift->{routine} }
sub severity { shift->{severity} }

sub type { $Protocol::Database::PostgreSQL::ERROR_CODE{shift->{code}} // 'unknown' }

1;

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2010-2019. Licensed under the same terms as Perl itself.

