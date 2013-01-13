require_relative '../pastebit'
require_relative './spec_helper'

ENV['RACK_ENV'] = 'test'

def app
  PasteBit.new
end

describe 'The PasteBit App' do

  it "displays the home page" do
    get '/'
    last_response.should be_ok
    last_response.body.include? "PasteBit"
  end

  it "displays a text area to paste content into" do
    get '/'
    last_response.body.include? 'textarea'
  end

  it "diplays a text area to paste into" do
    #visit '/'
    #page.should have_content 'textarea'
  end

end
