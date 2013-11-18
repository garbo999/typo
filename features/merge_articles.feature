Feature: Merge two articles
  As an author/admin user
  In order to merge separate content
  I want to combine two articles

Background: movies in database

  Given the following users exist:
  | login  | password | email             | profile_id |
  | User1  | password | user1@email.com   | 1          |
  | User2  | password | user2@email.com   | 1          |

  Given the following articles exist:
  | title     | body | author  | user_id  |
  | Article1  | PG   | Author1 | 1        |
  | Article2  | PG   | Author2 | 2        |

  Given the following comments exist:
  | title     | body | author  | user_id  | article_id  |
  | Article1  | PG   | Author1 | 1        | 1           |
  | Article2  | PG   | Author2 | 2        | 2           |

Scenario: Non-admin should not be able to merge articles
  Given I am on the Edit page
  And I am not logged in as Admin
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
