# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Dogeserver::Application.config.secret_key_base = 'b3f1aea7b189f579f8461e157e91c9b25088dc12d0e92f5ac458c662df6826b030e7546ec2835c88d25839b085ad183275ce7988393e0fcd964ba93448fcb1cc'
