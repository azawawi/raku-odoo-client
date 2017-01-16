use v6;
use JSON::RPC::Client;
use Odoo::Client::Model;

unit class Odoo::Client;

=begin pod

=head1 Name

Odoo::Client - A simple Odoo ERP client that uses JSON RPC

=head1 Synopsis

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

=head1 Description

A simple L<Odoo|http://odoo.com> ERP client that uses JSON RPC.

=head1 See Also

=item L<JSON-RPC Library|https://www.odoo.com/documentation/10.0/howtos/backend.html#json-rpc-library>

=head1 Author

Ahmad M. Zawawi, L<azawawi|https://github.com/azawawi> on C<#perl6>

=head1 LICENSE

MIT License

=end pod


has JSON::RPC::Client $!client;
has Str $!database;
has Str $!username;
has Str $!password;
has Int $!uid;

submethod BUILD(Str :$hostname, Int :$port) {
    my $url = sprintf("http://%s:%d/jsonrpc", $hostname, $port);
    $!client = JSON::RPC::Client.new(url => $url);
}

method version() {
    my $version = $!client.call(
        service => "common",
        method  => "version",
        args    => []
    );
    return $version;
}

method login(Str :$database, Str :$username, Str :$password) {
    my $uid = $!client.call(
        service => "common",
        method  => "login",
        args    => [$database, $username, $password]
    );
    if $uid.defined {
        $!database = $database;
        $!username = $username;
        $!password = $password;
        $!uid      = $uid;
    }
    return $uid;
}

multi method invoke(Str :$model, Str :$method, :$method-args) {
    my @args = [$!database, $!uid, $!password, $model, $method, $method-args];
    my $result = $!client.call(
        service => "object",
        method  => "execute",
        args    => @args
    );
    return $result;
}

method model(Str $name) {
    return Odoo::Client::Model.new(
        :client(self),
        :name($name)
    );
}
