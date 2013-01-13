require 'sinatra/base'

class PasteBit < Sinatra::Base

  get '/' do
    haml :index
  end

end
