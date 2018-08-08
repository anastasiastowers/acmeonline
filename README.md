# Acme Online

A response to a [challenge](https://gist.github.com/speric/bef88f6d0276e762316a073da81bbd35) issued by Chargify.

## App Structure

The structure of this app is inspired by [The Modular Monolith](https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4]). The app is separated out into 3 Engines: Payments, Storefront, and Templates.

The Payments Engine is an API that handles payment and subscription processing, as well as communication with the [Fakepay API](https://www.fakepay.io/).

The Storefront Engine is the customer-facing engine which handles customer login, settings, and checkout.

The Templates Engine holds all shared styles (CSS).

## Setup

1. Run `bundle install`
2. Run `rake db:create db:migrate db:seed`
3. From the rails console run `Payments::ApiKey.create(name:'development_key'')`. Use the returned token in any curl commands to the Payments Engine as detailed in the Payments Engine README.md
4. Create /config/secrets.yml and define `fakepay_API_key: 'your_fakepay_API_key'` under a development or shared scope
5. Add the following to your /etc/hosts file:
```
127.0.0.1	acmeonline.local
127.0.0.1	payments.acmeonline.local
```

## Usage

1. Run `bundle exec rails s` from the root folder
2. Also run `bundle exec sidekiq -q default` from the root folder (you must have sidekiq and redis)
3. Use curl commands as detailed in /engines/payments/README.md

## TODO

### Payments Engine

- Needs better separation of logic - status responses should not be in models
- Email notifications if purchase fails/succeeds
- Tests

### Storefront Engine
- Fix issue with calls made to Payments Engine
- Utilize saved Fakepay tokens ("saved credit cards")
- Front end validations & error reporting
- Tests