# GoogleAuthBox

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/google_auth_box`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'google_auth_box'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_auth_box

## Usage

```ruby 
require './lib/google_auth_box/client'
f = File.new './secret.json'

# go to google developer console
# to enable an api and download client_secrets as a json file
# then just load it and pass it as a Hash to the GAB::Client
client_data = JSON.parse(f.read)

# the client also takes scopes, a plain file for the data store
# and a callback where the refresh tokens will be sent
# don't worry about a refresh token, just expost an endpoint
# that can take a url with a query string param "code"
# and mayb gree the user with a nice response ;)
client = GoogleAuthBox::Client.new(
  client_id_hash: client_data,
  scopes: ['https://www.googleapis.com/auth/spreadsheets'],
  data_file_path: './data.yml',
  base_uri: 'http://mycooluri/oathcallback'
)

# grab this and send it to the user
p client.get_auth_url

# sometime later
# this would probably involve sending the url and receiving a api call
# with the base_uri above.  the query param "code" will contain the
# refresh token for google auth
code = '5/alongcode'
client.save_creds 7, code

# at this point the client with an id 7 will have their credentials persisted
p client.get_creds 7

```

