# README

This README would normally document whatever steps are necessary to get the
application up and running.

## HOWTO Setup the app:
```
cp .env.sample .env

bundle install

sudo apt install libleptonica-dev
sudo apt install libtesseract-dev

image = RTesseract.new(image_path)
image.to_s
will return image all in text format

rake db:setup
rails c
```
