require 'sinatra/base'
require_relative 'lib/content_storer'
require 'haml'
require 'rack-flash'

class PasteBit < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    @content = ContentStorer.new
    super
  end

  get '/' do
    locals = { :error_message => params[:error_message] }
    haml :index
  end

  post '/store' do
    if valid_pasted_content_available(params)
      store_content(params)
    else
      warn_user_about_invalid_pasted_content
    end
  end

  get '/:key' do
    content = @content.retreive params[:key]
    haml :content, :locals => {content: content}
  end

  private
  def valid_pasted_content_available(params)
    content = params[:pasted_content] || ''
    !(content.strip.empty?)
  end

  def warn_user_about_invalid_pasted_content
    flash[:error] = "You should enter some content before click the Paste button!"
    redirect '/'
  end

  def store_content(params)
    key = @content.store params[:pasted_content]
    redirect "/#{key}"
  end
end
