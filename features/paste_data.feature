Feature: Data can be pasted and retrieved
  In order to share snippets of text and code
  As a human using text
  I want to be able to paste stuff and get it back on a url

  Scenario: Users can paste data and retrieve it
    Given I have some text
    When I go to the homepage
    Then I can paste some text
    And be redirected to a unique page with the pasted content on
