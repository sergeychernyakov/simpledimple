# README

This README would normally document whatever steps are necessary to get the
application up and running.

## HOWTO Setup the app:
```
cp .env.sample .env

Install dependencies for rtesseract
sudo apt install libleptonica-dev
sudo apt install libtesseract-dev

bundle install

rake db:setup
rails c

Image can be converted to readable text using RTesseract
image = RTesseract.new(image_path)
image.to_s
This will return image in text format

```
