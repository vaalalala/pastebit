require_relative '../pastebit'
require_relative './spec_helper'

ENV['RACK_ENV'] = 'test'

def app
  PasteBit.new
end

describe 'The PasteBit App', type: :feature do
  let(:the_home_page){'/'}

  def the_paste_it_button
    within("form[@id='paste_form']") do
      find_button 'paste_button'
    end
  end

  it "displays the home page" do
    get the_home_page
    last_response.should be_ok
    last_response.body.include? "PasteBit"
  end

  it "displays a text area to paste content into" do
    visit the_home_page
    find("textarea").should be_visible
  end

  it "has a paste button" do
    visit the_home_page
    the_paste_it_button.should be_visible
  end

  it "returns you to a url with your content after pasting" do
    my_content = "Hello\nWorld!\n   How are you?"
    visit the_home_page
    fill_in "pasted_content", with: my_content
    the_paste_it_button.click

    current_path.should =~ /\/[a-zA-Z0-9]{40}/
    page.should have_content my_content
  end

  it "shows an error if you try to paste nothing" do
    visit the_home_page
    the_paste_it_button.click

    page.should have_content "You should enter some content before click the Paste button!"
  end

  it "shows you an error if you ask for a key which isn't there" do
    visit '/not-a-valid-key'

    page.should have_content 'Nothing is stored here yet!'
  end

  it "gives you a link to copy on the content page" do
    visit the_home_page
    fill_in "pasted_content", with: "some content"
    the_paste_it_button.click

    page.should have_content "Link to this page"
  end
end
