# Acme Online

A response to a [challenge](https://gist.github.com/speric/bef88f6d0276e762316a073da81bbd35) issued by Chargify.

## Setup

1. run `bundle install`
2. run `rake db:create db:migrate db:seed`
3. From the rails console run `Payments::ApiKey.create(name:'development_key'')`. Use the returned token in any curl commands to the Payments Engine as detailed in the Payments Engine README.md
4. Create /config/secrets.yml and define `fakepay_API_key: 'your_fakepay_API_key'` under a development or shared scope
5. Add the following to your /etc/hosts file:
```
127.0.0.1	acmeonline.local
127.0.0.1	payments.acmeonline.local
```

## Usage

1. run `bundle exec rails s` from the root folder
2. also run `bundle exec sidekiq -q default` from the root folder (you must have sidekiq and redis)
3. use curl commands as detailed in /engines/payments/README.md

## TODO

### Payments Engine

- needs more separation of logic - status responses should not be in models
- email notifications if purchase fails/succeeds
- tests

### Storefront Engine
- fix issue with calls made to Payments Engine
- utilize saved Fakepay tokens ("saved credit cards")
- front end validations & error reporting
- tests

## Inspiration

[The Modular Monolith](https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4])