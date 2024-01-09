# 
# Test that perlwhich executes and returns reasonable results.
# 

use strict;

use Test::More tests => 11;

# Test perlwhich on a known core module

my $result = `script/perlwhich Getopt::Std 2>&1`;

my $check = $result =~ m{[\\/]Getopt[\\/]Std.pm$};

print STDERR "RESULT: $result\n" unless $check;

ok($check, 'script executes without errors') ||
    BAIL_OUT "No point in continuing if perlwhich does not execute properly.";

my @lines = split /[\n\r]+/, $result;

is(scalar(@lines), 1, 'script produces one line ');

# Test the -v option

$result = `script/perlwhich -v Getopt::Std 2>&1`;

$check = $result =~ m{[\\/]Getopt[\\/]Std.pm version=\d};

print STDERR "RESULT: $result\n" unless $check;

ok($check, 'with option -v');

@lines = split /[\n\r]+/, $result;

is(scalar(@lines), 1, 'one line produced with -v');

# Test the -d option

$result = `script/perlwhich -d Getopt 2>&1`;

$check = $result =~ m{[\\/]Getopt$};

print STDERR "RESULT: $result\n" unless $check;

ok($check, 'with option -d');

@lines = split /[\n\r]+/, $result;

is(scalar(@lines), 1, 'one line produced with -d');

# Test the -a option bundled with -d

$result = `script/perlwhich -ad File 2>&1`;

$check = $result =~ m{[\\/]File$};

print STDERR "RESULT: $result\n" unless $check;

ok($check, 'with options -ad');

@lines = split /[\n\r]+/, $result;

cmp_ok(scalar(@lines), '>', 1, 'multiple lines produced with -a');

# Test the command result code

my $rc = system('script/perlwhich Getopt 1>/dev/null 2>/dev/null');

is($rc, 0, 'returns 0 when argument is found');

$rc = system('script/perlwhich NotA_::Module 1>/dev/null 2>/dev/null');

isnt($rc, 0, 'returns nonzero when argument is not found');

# Check for error on invalid option

$result = `script/perlwhich -foo File 2>&1`;

$check = $result =~ /^Invalid option/i;

print STDERR "RESULT: $result\n" unless $check;

ok($check, 'invalid option produces error');

