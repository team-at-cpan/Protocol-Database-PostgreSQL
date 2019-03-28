# NAME

Protocol::Database::PostgreSQL - support for the PostgreSQL wire protocol

# SYNOPSIS

    use strict;
    use warnings;
    use mro;
    package Example::PostgreSQL::Client;

    sub new { bless { @_[1..$#_] }, $_[0] }

    sub protocol {
     my ($self) = @_;
     $self->{protocol} //= Protocol::Database::PostgresQL->new(
      outgoing => $self->outgoing,
     )
    }
    # Any received packets will arrive here
    sub incoming { shift->{incoming} //= Ryu::Source->new }
    # Anything we want to send goes here
    sub outgoing { shift->{outgoing} //= Ryu::Source->new }

    ...
    # We raise events on our incoming source in this example -
    # if you prefer to handle each message as it's extracted you
    # could add that directly in the loop
    $self->incoming
      ->switch_str(
       sub { $_->type },
       authentication_request => sub { ... },
       sub { warn 'unknown message - ' . $_->type }
      );
    # When there's something to write, we'll get an event here
    $self->outgoing
         ->each(sub { $sock->write($_) });
    while(1) {
     $sock->read(my $buf, 1_000_000);
     while(my $msg = $self->protocol->extract_message(\$buf)) {
      $self->incoming->emit($msg);
     }
    }

# DESCRIPTION

Provides protocol-level support for PostgreSQL 7.4+, as defined in [http://www.postgresql.org/docs/current/static/protocol.html](http://www.postgresql.org/docs/current/static/protocol.html).

## How do I use this?

The short answer: don't.

Use [Database::Async::Engine::PostgreSQL](https://metacpan.org/pod/Database::Async::Engine::PostgreSQL) instead, unless you're writing a driver for talking to PostgreSQL (or compatible) systems.

This distribution provides the abstract protocol handling, meaning that it understands the packets that make up the PostgreSQL
communication protocol, but it does **not** attempt to send or receive those packets itself. You need to provide the transport layer
(typically this would involve TCP or Unix sockets).

## Connection states

Possible states:

- **Unconnected** - we have a valid instantiated PostgreSQL object, but no connection yet.
- **Connected** - transport layer has made a connection for us
- **AuthRequested** - the server has challenged us to identify
- **Authenticated** - we have successfully identified with the server
- **Idle** - session is active and ready for commands
- **Parsing** - a statement has been passed to the server for parsing
- **Describing** - the indicated statement is being described, called after the transport layer has sent the Describe request
- **Binding** - parameters for a given query have been transmitted
- **Executing** - we have sent a request to execute
- **ShuttingDown** - terminate request sent
- **CopyIn** - the server is expecting data for a COPY command

## Message types

The ["type" in Protocol::Database::Backend](https://metacpan.org/pod/Protocol::Database::Backend#type) for incoming messages can currently include the following:

- `send_request` - Called each time there is a new message to be sent to the other side of the connection.
- `authenticated` - Called when authentication is complete
- `copy_data` - we have received data from an ongoing COPY request
- `copy_complete` - the active COPY request has completed

For the client, the following additional callbacks are available:

- `request_ready` - the server is ready for the next request
- `bind_complete` - a Bind request has completed
- `close_complete` - the Close request has completed
- `command_complete` - the requested command has finished, this will typically be followed by an on\_request\_ready event
- `copy_in_response` - indicates that the server is ready to receive COPY data
- `copy_out_response` - indicates that the server is ready to send COPY data
- `copy_both_response` - indicates that the server is ready to exchange COPY data (for replication)
- `data_row` - data from the current query
- `empty_query` - special-case response when sent an empty query, can be used for 'ping'. Typically followed by on\_request\_ready
- `error` - server has raised an error
- `function_call_result` - results from a function call
- `no_data` - indicate that a query returned no data, typically followed by on\_request\_ready
- `notice` - server has sent us a notice
- `notification` - server has sent us a NOTIFY
- `parameter_description` - parameters are being described
- `parameter_status` - parameter status...
- `parse_complete` - parsing is done
- `portal_suspended` - the portal has been suspended, probably hit the row limit
- `ready_for_query` - we're ready for queries
- `row_description` - descriptive information about the rows we're likely to be seeing shortly

And there are also these potential events back from the server:

- `copy_fail` - the frontend is indicating that the copy has failed
- `describe` - request for something to be described
- `execute` - request execution of a given portal
- `flush` - request flush
- `function_call` - request execution of a given function
- `parse` - request to parse something
- `password` - password information
- `query` - simple query request
- `ssl_request` - we have an SSL request
- `startup_message` - we have an SSL request
- `sync` - sync request
- `terminate` - termination request

# METHODS

## new

Instantiate a new object. Blesses an empty hashref and calls ["configure"](#configure), subclasses can bypass this entirely
and just call ["configure"](#configure) directly after instantiation.

## configure

Does the real preparation for the object.

## frontend\_bind

Bind parameters to an existing prepared statement.

## frontend\_copy\_data

## frontend\_close

## frontend\_copy\_done

## frontend\_describe

Describe expected SQL results

## frontend\_execute

Execute either a named or anonymous portal (prepared statement with bind vars)

## frontend\_parse

Parse SQL for a prepared statement

## frontend\_password\_message

Password data, possibly encrypted depending on what the server specified.

## frontend\_query

Simple query

## frontend\_startup\_message

Initial mesage informing the server which database and user we want

## frontend\_sync

Synchonise after a prepared statement has finished execution.

## frontend\_terminate

## is\_authenticated

Returns true if we are authenticated (and can start sending real data).

## is\_first\_message

Returns true if this is the first message, as per [http://developer.postgresql.org/pgdocs/postgres/protocol-overview.html](http://developer.postgresql.org/pgdocs/postgres/protocol-overview.html):

    "For historical reasons, the very first message sent by the client (the startup message)
     has no initial message-type byte."

## send\_message

Send a message.

## method\_for\_frontend\_type

Returns the method name for the given frontend type.

## is\_known\_frontend\_message\_type

Returns true if the given frontend type is one that we know how to handle.

## message

Creates a new message of the given type.

## handle\_message

Handle an incoming message from the server.

## message\_length

Returns the length of the given message.

## simple\_query

Send a simple query to the server - only supports plain queries (no bind parameters).

## copy\_data

Send copy data to the server.

## copy\_done

Indicate that the COPY data from the client is complete.

## backend\_state

Accessor for current backend state.

## is\_ready

Returns true if we're ready to send more data to the server.

## send\_copy\_data

Send COPY data to the server. Takes an arrayref and replaces any reserved characters with quoted versions.

## build\_message

Construct a new message.

# SEE ALSO

Some PostgreSQL-related modules - plenty of things build on these so have a look at the relevant reverse deps if you're after something higher level:

- [DBD::Pg](https://metacpan.org/pod/DBD::Pg) - uses the official library and (unlike this module) provides full support for [DBI](https://metacpan.org/pod/DBI)
- [Pg::PQ](https://metacpan.org/pod/Pg::PQ) - another libpq wrapper
- [Postgres](https://metacpan.org/pod/Postgres) - quite an old (1998) libpq binding
- [Pg](https://metacpan.org/pod/Pg) - slightly less old (2000) libpq binding
- [DBD::PgPP](https://metacpan.org/pod/DBD::PgPP) - provides another pure-Perl implemmentation, with the focus on DBI compatibility

Other related database protocols:

- [Protocol::MySQL](https://metacpan.org/pod/Protocol::MySQL) - Oracle's popular database product
- [Protocol::TDS](https://metacpan.org/pod/Protocol::TDS) - the tabular data stream protocol, mainly of interest for SQL Server users

# AUTHOR

Tom Molesworth <TEAM@cpan.org>

# LICENSE

Copyright Tom Molesworth 2010-2019. Licensed under the same terms as Perl itself.
