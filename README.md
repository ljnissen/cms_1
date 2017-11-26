# This is the README for Coquilles' Content Management System (CMS)

A working demo app can be found at: https://secure-taiga-70457.herokuapp.com/

If you want to run this code as an admin, change seed.rb in config folder to your email and password
and make sure you have the PostgreSQL gem installed. In Gemfile:

group :production do
  gem 'pg', '0.20.0'
end

If you are using sqlite3 in development, also make sure that it is only used in development:

group :development, :test do
  gem 'sqlite3', '1.3.13'
end

To prepare for deployment use the bundle command:

$ bundle install --without production

Then run:

$ git add -A
$ git commit -m "Set up app"
$ git push

Make sure you have heroku installed by typing:

$ heroku version

Add your SSH keys by:

$ heroku login
$ heroku keys:add

Then we create a new app at Heroku with:

$ heroku create

Where you will receive address that is specific for you.

Then we push to heroku:

$ git push heroku master

And reset our database:

$ heroku pg:reset DATABASE

Run the migrations:

$ heroku run rails db:migrate

And seed:

$ heroku run rails db:seed 