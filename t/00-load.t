#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'IO::Vec' );
}

diag( "Testing IO::Vec $IO::Vec::VERSION, Perl $], $^X" );
