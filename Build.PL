use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name         => 'IO::Vec',
	license             => 'perl',
	dist_author         => 'Leon Timmermans <leont@cpan.org>',
	dist_version_from   => 'lib/IO/Vec.pm',
	build_requires      => {
		'Test::More'    => 0,
	},
	requires	        => {
		perl            => 5.006000,
	},
	add_to_cleanup      => [ 'IO-Vec-*' ],
	create_makefile_pl  => 'traditional',
	sign                => 1,
);

$builder->create_build_script();
