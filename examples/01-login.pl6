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
    die "Failed to login to odoo";
}

printf("Logged on with user id '%d'\n", $uid);

my $user-model = $odoo.model( 'res.users' );
say $user-model.perl;
my $user-ids = $user-model.search( [] );
say "user-ids: " ~ $user-ids.perl;

unless $user-ids.defined && $user-ids.elems > 0 {
    die "No users! found";
    return;
}

my $user-id = $user-ids[0];
my $user = $user-model.read([$user-id]);
die "Duplicate user id" if $user.elems > 1;
die "User not found!"   if $user.elems == 0;
say "user: " ~ $user[0].perl;

sub create-product($name, $type, $list-price, $image) {
    my $product-model = $odoo.model('product.product');
    return $product-model.create({
        "name"       => $name,
        "type"       => $type,
        "list_price" => $list-price,
        "image"      => $image
    });
}

# Create a product to be sold :)
my $red-dot-base64 = "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
my $product = create-product('Sample Service', 'service', 5.99, $red-dot-base64);
say $product.perl;
