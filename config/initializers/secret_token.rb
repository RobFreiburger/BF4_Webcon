# Secret key is stored as a environment variable on Heroku.
Bf4Webcon::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || ActiveRecord::KeyGenerator.generate_key(Random.new.rand(30..100))