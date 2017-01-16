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

say "Version: " ~ $odoo.version.perl;

unless $uid.defined {
    say "Failed to login to odoo";
    return;
}

printf("Logged on with user id '%d'\n", $uid);

constant MODEL = 'res.users';
my $user-ids   = $odoo.invoke(
    model  => MODEL,
    method => 'search',
    []
);
say "user-ids: " ~ $user-ids.perl;

if $user-ids.elems > 0 {
    my $user-id = $user-ids[0];
    my $user    = $odoo.invoke(
        model  => MODEL,
        method => 'read',
        [ $user-id ]
    );
    die "Duplicate user id" if $user.elems > 1;
    die "User not found!"   if $user.elems == 0;
    say "user: " ~ $user[0].perl;
} else {
    warn "No users! found";
}
