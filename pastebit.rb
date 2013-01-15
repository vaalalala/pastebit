require 'sinatra/base'
require_relative 'lib/content_storer'
require 'haml'

class PasteBit < Sinatra::Base
  def initialize
    @content = ContentStorer.new
    super
  end

  get '/' do
    haml :index
  end

  post '/store' do
    puts @content.inspect
    key = @content.store params[:pasted_content]
    redirect "/#{key}"
  end

  get '/:key' do
    content = @content.retreive params[:key]
    haml :content, :locals => {content: content}
  end

end
