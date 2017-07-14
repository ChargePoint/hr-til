Feature: Visitor views developer

  Scenario: Visitor views author page with a Twitter handle set
    Given I am a visitor
    When I visit the author page of an author with a Twitter handle
    Then I see the author's Twitter link

  Scenario: Visitor views author page with a Github handle set
    Given I am a visitor
    When I visit the author page of an author with a Github handle
    Then I see the author's Github link