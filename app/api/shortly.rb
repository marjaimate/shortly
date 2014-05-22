class API::Shortly < API::Base
  desc "Create short URL"
  params do
    requires :url, type: String, desc: "URL."
  end
  put '/' do
    Shortly.save(params[:url])
  end

  route_param :hash do
    get do
      puts params.inspect
      Shortly.get(params[:hash])
    end
  end
end
