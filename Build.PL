use strict;
use warnings;
use Module::Build;

Module::Build->new(
    'module_name'       => 'Data::FormValidator::EmailValid',
    'license'           => 'perl',
    'dist_author'       => 'Graham TerMarsch (cpan@howlingfrog.com)',
    'create_makefile_pl'=> 'traditional',
    'requires'          => {
        'Data::FormValidator'   => 4,
        'Email::Valid'          => 0,
        },
    'recommends'        => {
        'Net::DNS'              => 0,
        },
    )->create_build_script();
