#require 'twitter'
require 'openssl'

class AnalyticsController < ApplicationController
  before_filter :authenticate_user!

   Koala.http_service.http_options = {
      :ssl => { :verify => false }
   }
   def index
   end

   def facebook
      #move to application level later
      config = {'app_id' => 313457693212, 'secret' => '9725e6e77e07a48e4cb45fe56c7fc2db', 'token' => 'AAACEdEose0cBAOdInaZBaX3ZCElTb3SqJGnYoVffowEIBGQDnNDNmzN13iGZCWr2ekW8ZCXWG2yZCMm8PRkf61vHd2usZB17IZD'}
      client = Koala::Facebook::API.new(config['token'])

      #have to keep within 7776000
      #@results = client.get_connections(config['app_id'], 'insights', {"since" => DateTime.new(2011,1,1), "until" => DateTime.new(2011, 4,1)}, {"access_token" => client.access_token})

      @likes = { 'total' => '5237', 'percent' => '2.0'}
      @friends_of_fans = {}
      @grape_vine = {}
      @reach = {}

      @results = client.get_connections(config['app_id'], 'insights/page_views_login_unique',
                                        {"since" => DateTime.new(2009, 1, 1), "until" => DateTime.new(2009, 4, 1)},
                                        {"access_token" => client.access_token})

   end

   def twitter
=begin
      Twitter.configure do |config|
         config.consumer_key = 'lkvDE3yCBBZUueaqIQl6ug'
         config.consumer_secret = '4VkEt1JeW315PneZV91rdi0RNyZZkCyzs4TG0K2DeB8'
         config.oauth_token = '14385890-Hmps0xKFzSr4dwlO8J29THBHkvZGUzaLmXe2LmgwK'
         config.oauth_token_secret = 'MsCKtsbgtpOltkoQlIIM06hM1Sz4tRztSreFnhZAZ6Y'
      end
=end
   end

end