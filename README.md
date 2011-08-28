# Chatte

This is a tiny chat server and client built in Ruby.

This was written to learn to use sockets in Ruby and probably should not be used in a production environment.

![screenshot](https://github.com/andmej/chatte/blob/master/img/screenshot.png?raw=true)

## How to run

I tested this on Ruby 1.9.2. You probably need that or a more recent version for this to work.

Run the server:

    $ ruby server.rb 1234
    Starting Chatte server. Listening for connections on port 1234...

Then run the client:

    $ ruby client.rb localhost 1234
    Enter your nickname:
    andmej
    Connecting...
    andmej just joined the chatte

Then chatte freely.

## What's in a name?

Chatte means pussy in French.