# Acme Online Payments API
Make payments and set up recurring billing for Acme Online.

## Usage

### Access

All requests should include the following headers:

`--header "Content-Type: application/json"`

`--header "Authentication: API_KEY"`

Replace API_KEY with your API Key. All of the resource data should be included as `--data`

### Resources

#### Subscriptions

##### Create Subscription

`POST` request to `/subscriptions`

###### Fields

`customer_id` - Id of the customer from the Storefront DB

`plan_name` - options: `Bronze Box`, `Silver Box`, or `Gold Box` 

*`card_number` - a valid credit card number
 
*`cvv` - cvv associated with the credit card

*`expiration_month` - expiration month associated with the credit card

*`expiration_year` - expiration year associated with the credit card

*`zip_code` - zip code associated with the credit card

**`fakepay_token` - the token associated with an existing Fakepay credit card
  
Note: 
All fields not marked with a * are required. Every request requires either a `card_number` or a `fakepay_token`. If the `card_number` is sent, all of the fields denoted with the * are also required.

###### Example request

```
curl --header "Content-Type: application/json" \
--header "Authentication: fdEYbNVCxDcsEPyQpa3SuLmz" \
--request POST \
--data '{"customer_id": 1, "plan_name": "Gold Box", "card_number": "4242424242424242", "cvv": "123", "expiration_month": "01", "expiration_year": "2024", "zip_code": "10045"}' \
http://payments.acmeonline.local:3000/subscriptions
```

##### Show Subscription

`GET` request to `/subscriptions/:id`

###### Example request

```
curl --header "Content-Type: application/json" \
--header "Authentication: fdEYbNVCxDcsEPyQpa3SuLmz" \
--request GET \
http://payments.acmeonline.local:3000/subscriptions/1
```

##### Update Subscription

`PUT` request to `/subscriptions/:id`

###### Fields

`active` - denotes whether or not the subscription is active - options: `true` or `false`

###### Example request

```
curl --header "Content-Type: application/json" \
--header "Authentication: fdEYbNVCxDcsEPyQpa3SuLmz" \
--request POST \
--data '{"active":false}' \
http://payments.acmeonline.local:3000/subscriptions/1
```

#### Subscribers

##### Show Subscriber

`GET` request to `/subscribers/:id`

###### Example request

```
curl --header "Content-Type: application/json" \
--header "Authentication: fdEYbNVCxDcsEPyQpa3SuLmz" \
--request GET \
http://payments.acmeonline.local:3000/subscribers/1
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'payments'
```

And then execute:
```bash
$ bundle
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
