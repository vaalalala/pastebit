require_relative '../pastebit'
require_relative './spec_helper'

ENV['RACK_ENV'] = 'test'

def app
  PasteBit
end

describe 'The PasteBit App', type: :feature do

  it "displays the home page" do
    get '/'
    last_response.should be_ok
    last_response.body.include? "PasteBit"
  end

  it "displays a text area to paste content into" do
    visit '/'
    find("textarea").should be_visible
  end

end
