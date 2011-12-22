require "#{File.dirname(__FILE__)}/../lib/heroku-rb"

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'

def heroku
  Heroku.new(:api_key => 'API_KEY', :mock => true)
end

def random_app_name
  "heroku-rb-#{now}"
end

def random_email_address
  "heroku-rb@#{now}.com"
end

def now
  Time.now.to_f.to_s.gsub('.','')
end

def with_app(params={}, &block)
  begin
    data = heroku.post_app(params).body
    @name = data['name']
    yield(data)
  ensure
    heroku.delete_app(@name) rescue nil
  end
end
