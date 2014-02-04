# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Scheduler::Application.config.secret_key_base = '1aff0600213c912c7e4a0bacd094f9217503fcada0953257a59ca5b1a88710254527bf8c12f985b6f694fae55b1c1b35ffe02226bf01f24fe9ab37b7e8f06927'
