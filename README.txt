NAME
    Data::FormValidator::EmailValid - Data::FormValidator e-mail address
    constraint/filter

SYNOPSIS
      use Data::FormValidator::EmailValid qw(filter_email_valid constrain_email_valid);

      $results = Data::FormValidator->check(
            { 'email' => 'Graham TerMarsch <cpan@howlingfrog.com>',
            },
            { 'required' => [qw( email )],
              'field_filters' => {
                  'email' => filter_email_valid(),
              },
              'constraint_methods' => {
                  'email' => constrain_email_valid(),
              },
            );

DESCRIPTION
    "Data::FormValidator::EmailValid" implements a constraint and filter for
    use with "Data::FormValidator" that do e-mail address
    validation/verification using "Email::Valid".

    Although I generally find that I'm using the filter and constraint
    together, they've been separated so that you could use just one or the
    other (e.g. you may want to constrain on valid e-mail addresses without
    actually modifying any of the data provided to you by the user).

METHODS
    filter_email_valid(%options)
        Filter method which cleans up the given value and returns valid
        e-mail addresses (or nothing, if the value isn't a valid e-mail
        address).

        "Valid" is deemed to mean "looks like an e-mail"; no other tests are
        done to ensure that a valid MX exists or that the address is
        actually deliverable.

        You may also pass through any additional "Email::Valid" %options
        that you want to use; they're handed straight through to
        "Email::Valid".

    constrain_email_valid(%options)
        Constraint method which checks to see if the value being constrained
        is a valid e-mail address or not. Returns true if the e-mail address
        is valid, false otherwise.

        This differs from the "email" constraint that comes with
        "Data::FormValidator" in that we not only check to make sure that
        the e-mail looks valid, but also that a valid MX record exists for
        the address. No other checks are done to ensure that the address is
        actually deliverable, however.

        You can also pass through any additional "Email::Valid" %options
        that you want to use; they're handed straight through to
        "Email::Valid".

AUTHOR
    Graham TerMarsch (cpan@howlingfrog.com)

COPYRIGHT
    Copyright (C) 2007, Graham TerMarsch. All Rights Reserved.

    This is free software; you can redistribute it and/or modify it under
    the same license as Perl itself.

SEE ALSO
    Data::FormValidator, Email::Valid.

