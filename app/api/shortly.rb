class API::Shortly < API::Base
  desc "Create short URL"
  params do
    requires :url, type: String, desc: "URL."
  end
  put '/' do
    hash = Shortly.save(params[:url])
    "#{Application.config.base_path}/#{hash}"
  end

  route_param :hash do
    get do
      url = Shortly.get(params[:hash])
      # redirect to url with 302
      redirect url, permanent: true
    end
  end
end
