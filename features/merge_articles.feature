Feature: Merge two articles
  As an author/admin user
  In order to merge separate content
  I want to combine two articles

Background: Articles in database

  #Given the following users exist:
  #| login  | password | email             | profile_id |
  #| admin  | password | user1@email.com   | 1          |
  #| User2  | password | user2@email.com   | 1          |

  Given the following articles exist:
  | title     | body    | author  | user_id  |
  | Article1  | Body1   | Author1 | 1        |
  | Article2  | Body1   | Author2 | 2        |

  #Given the following comments exist:
  #| title     | body | author  | user_id  | article_id  |
  #| Article1  | PG   | Author1 | 1        | 1           |
  #| Article2  | PG   | Author2 | 2        | 2           |

Scenario: Admin should see button to merge articles
  Given the blog is set up
  And I am logged into the admin panel
  And I am on the Edit page
  Then I should see "Merge Articles"

Scenario: Use debugger
  Then use debugger

Scenario: Non-admin should not be able to merge articles
  Given I am on the Edit page
  And I am logged in as Blog Publisher
  Then I should not see "Merge Articles"

Scenario: When articles are merged, the merged article should contain the text of both previous articles
  Given I am logged in as Admin
  And on the Edit page for Article1
  And I enter the Article ID for Article2 in the "merge_with" field
  And I click the Merge button
  Then I should be on the merged article page
  And I should see the body from Article1 and Article2
  And the author should be Author1
  And the title should be from Article1
  And comments on each of the two original articles need to all carry over and point to the new, merged article
