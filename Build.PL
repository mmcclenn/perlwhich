use Module::Build;
my $builder = Module::Build->new(
    dist_name         => 'perlwhich',
    license           => 'perl',
    dist_author         => q{Michael McClennen <mmcclenn@gmail.com>},
    dist_version_from   => 'script/perlwhich',
    release_status      => 'stable',
    configure_requires => {
	'Module::Build' => '0.42',
    },
    test_requires => {
        'Test::More' => '0',
    },
    requires => {
	'Pod::Usage' => '0',
	'perl' => '5.10.1',
    },
    script_files => 'script/perlwhich',
);

$builder->create_build_script();
