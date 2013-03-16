Feature: Syntax highlighting on languages when we know what they are
  In order to make shared code nicer to read
  As a user
  I want to have my language detected and the syntax highlighted

  Scenario: Popular language is identifyied and highlighted
    Given I paste some Ruby
    When I view the pasted code
    Then keywords should show up in different colours
