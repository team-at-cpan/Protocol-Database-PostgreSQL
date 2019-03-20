# Notes

## Simple SQL query

A plain query is similar to [DBI->do()](). This accepts a string representing an SQL query, with optional bind parameters.

```perl
$dbh->query('select * from t1');
```

The response object from this provides the following capabilities:

* Cancel query
* Attach stream for results
* Completion
* Handle failure

For completion and/or failure, use ->completion to get access to a [Future]().

The result stream emits one item for each row. Each item is a row object containing information about the metadata, as a reference to the original RowDescription, and the raw data values.

Where possible the minimal amount of translation is applied to all incoming values so as to reduce any unnecessary overheads. However, typical queries may benefit from features such as named field lookups and automatic value translation.

## Results

Each row is emitted as an item. This means that we don't have a good mechanism for dealing with massive amounts of data in existing fields, but we can support an unlmited number of rows.

## LISTEN/NOTIFY

There's two parts to this:

### listen

This will allow you to accept any message published via NOTIFY.

```perl
my $listener = $dbh->listen('whatever')->each(sub {
 $log->infof(
  "Notification on channel %s from pid %d with payload %s",
  $_->channel,
  $_->pid,
  $_->payload
 );
});

# These two are equivalent
$listener->notify('payload');
$dbh->notify(whatever => 'payload');

# Discard when no longer needed
$listener->cancel;
```

This will give you a stream to which notifications are emitted.


