# Odoo::Client

[![Actions
Status](https://github.com/azawawi/raku-odoo-client/workflows/test/badge.svg)](https://github.com/azawawi/raku-odoo-client/actions)

A simple Odoo ERP client that uses JSON RPC.

## Example

```Raku
use v6;
use Odoo::Client;

my $odoo = Odoo::Client.new(
    hostname => "localhost",
    port     => 8069
);

my $uid = $odoo.login(
    database => "<database>",
    username => '<email>',
    password => "<password>"
);
printf("Logged on with user id '%d'\n", $uid);
```

For more examples, please see the [examples](examples) folder.

## Installation

To install it using zef (a module management tool bundled with Rakudo Star):

```
$ zef install Odoo::Client
```

## Testing

- To run tests:
```
$ prove --ext .rakutest -ve "raku -I."
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove --ext .rakutest -ve "raku -I."
```

## See Also

- [JSON::RPC](https://github.com/bbkr/jsonrpc)
- [Odoo ERP](http://odoo.com)
- [JSON-RPC Library](https://www.odoo.com/documentation/10.0/howtos/backend.html#json-rpc-library)

## Author

Ahmad M. Zawawi, [azawawi](https://github.com/azawawi/) on #raku

## License

MIT License
