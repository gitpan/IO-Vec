#! /perl -T
use strict;
use warnings;
use Test::More tests => 1;
use IO::Vec qw/writev readv/;

my @test = ('abc', 'def', "\n");
my @copy = @test;

pipe my $in, my $out;

writev $out, @test;
readv $in, @test;

is(@test, @copy, "Input is output");
