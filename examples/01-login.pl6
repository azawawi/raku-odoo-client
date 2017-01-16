#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Odoo::Client;

my $odoo = Odoo::Client.new(
    hostname => "localhost",
    port     => 8069
);

# Login to odoo
my $uid = $odoo.login(
    database => "sample", 
    username => 'user@example.com',
    password => "123"
);
printf("Logged on with user id '%d'\n", $uid);
