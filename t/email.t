use strict;
use warnings;
use Test::More tests => 10;
use Data::FormValidator;
BEGIN {
    use_ok( 'Data::FormValidator::EmailValid', qw(FV_email_filter FV_email) );
}

###############################################################################
test_filter: {
    my $results = Data::FormValidator->check(
        { 'good'                => 'test@example.com',
          'good-with-name'      => 'Test User <test@example.com>',
          'good-case-mangled'   => 'TEST@eXaMpLe.CoM',
          'good-case-preserved' => 'TEST@eXaMpLe.CoM',
          'bad-no-domain'       => 'test@',
          'bad-no-user'         => '@example.com',
          'bad-not-email'       => 'not an e-mail address',
        },
        { 'required' => [qw(
            good good-with-name good-case-mangled good-case-preserved
            bad-no-domain bad-no-user bad-not-email
            )],
          'field_filters' => {
              'good'                => FV_email_filter(),
              'good-with-name'      => FV_email_filter(),
              'good-case-mangled'   => FV_email_filter(),
              'good-case-preserved' => FV_email_filter(lc=>0),
              'bad-no-domain'       => FV_email_filter(),
              'bad-no-user'         => FV_email_filter(),
              'bad-not-email'       => FV_email_filter(),
          },
        } );
    is(  $results->valid('good'),                   'test@example.com', 'filter: good' );
    is(  $results->valid('good-with-name'),         'test@example.com', 'filter: good-with-name' );
    is(  $results->valid('good-case-mangled'),      'test@example.com', 'filter: good-case-mangled' );
    is(  $results->valid('good-case-preserved'),    'TEST@eXaMpLe.CoM', 'filter: good-case-preserved' );
    ok( !$results->valid('bad-no-domain'),          'filter: bad-no-domain' );
    ok( !$results->valid('bad-no-user'),            'filter: bad-no-user' );
    ok( !$results->valid('bad-not-email'),          'filter: bad-not-email' );
}

###############################################################################
test_constraint: {
    my $results = Data::FormValidator->check(
        { 'good'        => 'test@example.com',
          'bad-no-mx'   => 'test@this-domain-doesnt-exist-anywhere.com',
        },
        { 'required' => [qw(
            good
            bad-no-mx
            )],
          'constraint_methods' => {
              'good'        => FV_email(),
              'bad-no-mx'   => FV_email(),
          },
        } );
    is(  $results->valid('good'),               'test@example.com', 'constraint: good' );
    ok( !$results->valid('bad-no-mx'),          'constraint: bad-no-mx' );
}
