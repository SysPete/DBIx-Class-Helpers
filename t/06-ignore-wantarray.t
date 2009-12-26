#!perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use Test::More;

use TestSchema;
my $schema = TestSchema->connect('dbi:SQLite:dbname=dbfile');
$schema->deploy();
$schema->populate(Foo => [
   [qw{id bar_id}],
   [1,1],
   [2,2],
   [3,3],
   [4,4],
   [5,5],
]);

$schema->populate(Bar => [
   [qw{id foo_id}],
   [1,1],
   [2,2],
   [3,3],
   [4,4],
   [5,5],
]);

my ($rs) = $schema->resultset('Foo')->search;
my ($rs2) = $schema->resultset('Bar')->search;
my ($rs3) = $schema->resultset('Foo')->first->bars;
my ($rs4) = $schema->resultset('Bar')->first->foos;

isa_ok $rs, 'DBIx::Class::ResultSet';
isa_ok $rs2, 'DBIx::Class::ResultSet';
isa_ok $rs3, 'DBIx::Class::ResultSet';
isa_ok $rs4, 'DBIx::Class::ResultSet';

done_testing;

END { unlink 'dbfile' unless $^O eq 'Win32' }
