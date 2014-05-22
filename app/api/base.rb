require 'redis'

class API::Base < Grape::API
  def self.inherited(subclass)
    super

    subclass.instance_eval do
      format :txt
      content_type :txt, "text/plain"
      rescue_from Redis::BaseError do |e|
        puts "Redis error"
        Rack::Response.new({
          error: "#{e.class} error",
          message: e.message
        }.to_json, 500).finish
      end
    end
  end

  default_format :txt
  content_type :txt, "text/plain"
end
