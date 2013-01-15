require_relative '../pastebit'
require_relative './spec_helper'

ENV['RACK_ENV'] = 'test'

def app
  PasteBit.new
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

  it "has a paste button"

  it "returns you to a url with your content when you paste something" do
    my_content = "Hello\nWorld!\n   How are you?"
    visit '/'
    fill_in "pasted_content", with: my_content
    click_on "Paste"

    current_path.should =~ /\/[a-zA-Z0-9]{40}/
    page.should have_content my_content
  end

  it "shows an error if you try to paste nothing"

end
