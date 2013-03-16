Given /^I paste some Ruby$/ do
  visit '/'
  @content = "
    class foo
      def hi
        puts 'hello world!'
      end
    end"
  fill_in "pasted_content", with: @content
end

When /^I view the pasted code$/ do
  find_button('paste_button').click
end

Then /^keywords should show up in different colours$/ do
  page.has_css? 'pre span.k'
  page.first('pre/span').text.should == 'class'
end
