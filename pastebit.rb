require 'sinatra/base'
require_relative 'lib/content_storer'
require 'haml'

class PasteBit < Sinatra::Base
  def initialize
    @content = ContentStorer.new
    super
  end

  def valid_content_available(params)
    content = params[:pasted_content]
    !(content.nil? || content.to_s.empty?)
  end

  def warn_user_about_nil_content
    params[:error_message] = "You should enter some content before click the Paste button!"
    params[:error_on] = [:pasted_content]
    redirect '/'
  end

  def store_content(params)
    key = @content.store params[:pasted_content]
    redirect "/#{key}"
  end

  get '/' do
    locals = { :error_message => params[:error_message] }
    locals = { :error_message => "Hello!"}
    haml :index, :locals => locals
  end

  post '/store' do
    if valid_content_available(params)
      store_content(params)
    else
      warn_user_about_invalid_content
    end
  end

  get '/:key' do
    content = @content.retreive params[:key]
    haml :content, :locals => {content: content}
  end
end
