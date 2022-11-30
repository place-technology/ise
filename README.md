# Cisco ISE ERS client

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     ise:
       github: place-technology/ise
   ```

2. Run `shards install`

## Usage

```crystal
require "ise"

session = ISE::Session.new(base_url: "https://10.81.12.11:9060/ers/config", username: "admin", password: "C1sco12345")
client = ISE::Client.new(session: session)

pp client.internal_user.list
```

## Contributing

1. Fork it (<https://github.com/place-technology/ise/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Giorgi Kavrelishvili](https://github.com/grkek) - creator and maintainer
