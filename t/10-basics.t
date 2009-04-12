#! /perl -T
use strict;
use warnings;
use Test::More tests => 2;
use IO::Vec qw/writev readv/;

my @test = ('abc', 'def', "\n");
my @copy = @test;

pipe my $in, my $out;

writev $out, @test;
readv $in, @test;

is(@test, @copy, "Input is output");

writev $out, reverse @test;
readv $in, @copy;

is(@copy, () = reverse(@test), "Second input is output")
