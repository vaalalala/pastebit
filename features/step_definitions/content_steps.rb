require 'capybara/cucumber'
require_relative '../../pastebit'
Capybara.app = PasteBit.new

Given /^I have some text$/ do
  @content = "Hello world!"
end


When /^I go to the homepage$/ do
  visit '/'
end

Then /^I can paste some text$/ do
  fill_in "pasted_content", with: @content
  find_button('paste_button').click
end

Then /^be redirected to a unique page$/ do
  current_path.should =~ /\/[a-zA-Z0-9]{40}/
end

Then /^be redirected to a unique page with the pasted content on$/ do
  page.should have_content @content
end
