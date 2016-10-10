[![Build Status](https://travis-ci.org/andela-hmasila/shotn.svg?branch=develop)](https://travis-ci.org/andela-hmasila/shotn)
[![Coverage Status](https://coveralls.io/repos/github/andela-hmasila/shotn/badge.svg?branch=develop)](https://coveralls.io/github/andela-hmasila/shotn?branch=develop)
[![Code Climate](https://codeclimate.com/github/andela-hmasila/shotn/badges/gpa.svg)](https://codeclimate.com/github/andela-hmasila/shotn)
[![Issue Count](https://codeclimate.com/github/andela-hmasila/shotn/badges/issue_count.svg)](https://codeclimate.com/github/andela-hmasila/shotn)
# shotn
shotn is a URL shortening service. The application accepts really long URLs and turns them into short URLs for easy use in email and social media. Registered users have the privilege of customizing the shorter URL to a string they can remember. Additionally, the user can update or delete the shortened URL at will.

### Application Features

  1. Shortens a long URL to a much shorter URL that is easier to remember
  2. Can accept a vanity string to provide a customized URL for registered users
  3. User is able to edit the customized URL.
  4. User can activate and deactivate shortened URL at will
  5. User can delete shortened URL at will
  6. Shows the top users on the application based on their number of shortened URLs
  7. Sorts shortened URLs by how recent they were created.
  8. Sorts shortened URLs by how many times they have been clicked.

### Dependencies

  1. [Ruby](https://github.com/rbenv/rbenv)
  2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
  3. [Bundler](http://bundler.io/)
  4. [Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
  5. [RSpec](http://rspec.info/)

### Running the application
Clone the application to your local machine:

    $ git clone https://github.com/andela-hmasila/shotn.git
Navigate to the shotn directory

    $ cd shotn

Install the dependencies

    $ bundle install
Setup database and seed data

    $ rake db:setup
Start the server

    $ rails server

Visit http://localhost:3000 to view the application on your preferred web browser.

### Testing

Run the following command from the terminal to get all tests running

    $ rspec spec

### Limitations
Vanity string can only be less than 6 characters
A little bit slow when generating a short url

### Contributing

1. Fork it! [Fork shotn on Github](https://github.com/andela-hmasila/shotn/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### License
This project is licensed under the MIT License - see the [LICENSE.md](https://opensource.org/licenses/MIT) file for details
