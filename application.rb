require File.expand_path('../environment', __FILE__)

module API
end

require 'app/api/base'

Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each {|f| require f}

class API::Root < Grape::API
  format :txt

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  mount API::Shortly
  mount API::Admin
end

ApplicationServer = Rack::Builder.new {
  map "/" do
    run API::Root
  end
}
