class API::Admin < API::Base
  desc "Admin interface"
  resource :admin do
    desc "Returns the stats"
    namespace :stats do
      desc "Access stats"
      get '/' do
        Shortly.stats
      end

      desc "Get domain specific stats"
      route_param :domain do
        get do
          Shortly.stats(params[:domain])
        end
      end
    end
  end
end
