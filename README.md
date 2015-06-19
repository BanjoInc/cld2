# Compact Language Detection 2.0

[![Gem Version](https://badge.fury.io/rb/cld2.svg)](http://badge.fury.io/rb/cld2)

![image](https://circleci.com/gh/BanjoInc/cld2.png?circle-token=6e9c5831521447a5005be3f4d33a221e9d2ae1d4)

Based on Jason Toy's CLD v1.0.
Blazing-fast language detection for Ruby provided by Google Chrome's Compact Language Detector v2.0

## How to Use

```ruby
CLD.detect_language("This is a test")
# => {:name => "ENGLISH", :code => "en", :reliable => true}

CLD.detect_language("plus ça change, plus c'est la même chose")
# => {:name => "FRENCH", :code => "fr", :reliable => true}

CLD.detect_language_summary("hello world")
# => {:result=>{:name=>"ENGLISH", :code=>"en", :reliable=>true}, :summary=>[{:name=>"ENGLISH", :code=>"en", :confidence=>92}, {:name=>"Unknown", :code=>"un", :confidence=>0}, {:name=>"Unknown", :code=>"un", :confidence=>0}]}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cld2', require 'cld'
```

And then execute:

```sh
$ bundle
```

## Thanks

Thanks to the Chrome authors, and to Mike McCandless for writing a Python version.
Thanks to Jason Toy for the original cld v1.0 ruby port.

Licensed the same as Chrome.
