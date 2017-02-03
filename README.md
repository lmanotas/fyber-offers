# Offers
A minimalist Ruby web application using Sinatra framework.
* Request to Fyber Offers API are done by `Fyber::Offer` library class. see `lib/fyber/offer.rb`
* Simple Sinatra Application with 2 endpoints, (get '/' and post '/'). see `app.rb`
  * get '/' renders the main page.
  * post '/', uses `Fyber::Offer` class to get the current offers using params sent by form.
## Getting Started
Make sure you have Ruby 2.2.2.
````
$ bundle install
````
## Running Tests
``` 
  $ rake
```
And using Bundler:
````
$ bundle exec rspec
````
## Play with it!
Currently deployed on Heroku: [http://fyber-api-offers.herokuapp.com](http://fyber-api-offers.herokuapp.com/)
