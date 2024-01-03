# 
# Test that perlwhich executes and returns reasonable results.
# 

use strict;

use Test::More tests => 8;

my $result = `script/perlwhich Getopt::Std`;

my $check = $result =~ m{/Getopt/Std.pm$};

print STDERR $result unless $check;

ok($check, 'script executes without errors') ||
    BAIL_OUT "No point in continuing if perlwhich does not execute properly.";

my @lines = split /[\n\r]+/, $result;

is(scalar(@lines), 1, 'script produces one line ');

$result = `script/perlwhich -v Getopt::Std`;

$check = $result =~ m{/Getopt/Std.pm version=\d};

print STDERR $result unless $check;

ok($check, 'with option -v');

@lines = split /[\n\r]+/, $result;

is(scalar(@lines), 1, 'one line produced with -v');

$result = `script/perlwhich -d Getopt`;

$check = $result =~ m{/Getopt$};

print STDERR $result unless $check;

ok($check, 'with option -d');

@lines = split /[\n\r]+/, $result;

is(scalar(@lines), 1, 'one line produced with -d');
    
$result = `script/perlwhich -ad File`;

$check = $result =~ m{/File$};

print STDERR $result unless $check;

ok($check, 'with options -ad');

@lines = split /[\n\r]+/, $result;

cmp_ok(scalar(@lines), '>', 1, 'multiple lines produced with -a');

    

