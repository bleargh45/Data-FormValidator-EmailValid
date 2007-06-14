use strict;
use warnings;
use Test::More tests => 4;
use Data::FormValidator;
BEGIN {
    use_ok( 'Data::FormValidator::EmailValid', qw(filter_email_valid constrain_email_valid) );
}

###############################################################################
test_filter_email_valid: {
    my $results = Data::FormValidator->check(
        { 'email' => 'Graham TerMarsch <cpan@howlingfrog.com>',
        },
        { 'required' => [qw( email )],
          'field_filters' => {
              'email' => filter_email_valid(),
          },
        } );
    is( $results->valid('email'), 'cpan@howlingfrog.com', 'e-mail filtered ok' );
}

###############################################################################
test_constrain_email_valid: {
    my $results = Data::FormValidator->check(
        { 'good'    => 'cpan@howlingfrog.com',
          'bad'     => 'invalid@host.doesnt.exist.howlingfrog.com',
        },
        { 'required' => [qw( good bad )],
          'constraint_methods' => {
              'good' => constrain_email_valid(),
              'bad'  => constrain_email_valid(),
          },
        } );
    ok(  $results->valid('good'), 'positive test for constrain_email_valid' );
    ok( !$results->valid('bad'),  'negative test for constrain_email_valid' );
}
