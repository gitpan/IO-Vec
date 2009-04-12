package IO::Vec;

use strict;
use warnings;
use bytes;
our $VERSION = '0.02';

use base qw/Exporter/;
use Symbol qw/qualify_to_ref/;

BEGIN { 
	package IO::Vec::Constants;
	use Carp qw/croak/;
	local $SIG{__WARN__} = sub { warn $_[0] unless $_[0] =~ /__LONG_MAX__/ };
	eval { require 'syscall.ph'; 1 } or croak 'Couldn\'t load syscell definitions: $@';
}

our @EXPORT_OK = qw/writev readv/;

sub writev(*@) {
	my $fh = qualify_to_ref(shift, caller);
	my $vector = join '', map { pack 'PI', $_, length } @_;
	return syscall IO::Vec::Constants::SYS_writev, fileno $fh, $vector, scalar @_;
}

sub readv(*@) {
	my $fh = qualify_to_ref(shift, caller);
	my $vector = join '', map { pack 'PI', $_, length } @_;
	return syscall IO::Vec::Constants::SYS_readv, fileno $fh, $vector, scalar @_;
}

1;

__END__

=head1 NAME

IO::Vec - writev and readv in perl

=head1 VERSION

Version 0.02

=head1 SYNOPSIS

    use Sys::IOVec qw/writev readv/;

	my @foo = qw/foo bar bas/;
	writev STDOUT, @foo;
	readv STDIN, @foo;

=head1 FUNCTIONS

=head2 writev *filehandle, @values

Write the values.

=head2 readv *filehandle, @values

Read the data into the values. The values will not be resized, but filled as much as possible using their current size.

=head1 AUTHOR

Leon Timmermans, C<< <fawaka at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-sys-iovec at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Sys-IOVec>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Sys::IOVec

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Sys-IOVec>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Sys-IOVec>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Sys-IOVec>

=item * Search CPAN

L<http://search.cpan.org/dist/Sys-IOVec>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2008 Leon Timmermans, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
