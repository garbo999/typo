Feature: Merge two articles
  As an author/admin user
  In order to merge separate content
  I want to combine two articles

Background: Users, articles and comments in database

  Given the blog is set up for CS169.2x

  #Given the following users exist:
  #| login  | password | email             | profile_id |
  #| admin  | password | user1@email.com   | 1          |
  #| User2  | password | user2@email.com   | 1          |

  And the following articles exist:
  | title     | body                | author  | published | user_id  |
  | Article1  | text of article 1   | Author1 | true      | 1        |
  | Article2  | text of article 2   | Author2 | true      | 2        |
  | Article3  | text of article 3   | Author3 | true      | 3        |

  And the following comments exist:
  | title     | body                | author  | user_id  | article_id  |
  | Comment1  | text of comment 1   | Author1 | 1        | 3           |
  | Comment2  | text of comment 2   | Author2 | 1        | 4           |
  | Comment3  | text of comment 3   | Author2 | 1        | 4           |
  | Comment4  | text of comment 4   | Author2 | 1        | 4           |

# Comment.column_names => ["id", "type", "title", "author", "body", "excerpt", "created_at", "updated_at", "user_id", "guid", "text_filter_id", "whiteboard", "article_id", "email", "url", "ip", "blog_name", "published", "published_at", "state", "status_confirmed"]

Scenario: Use debugger
  Then use debugger

Scenario: Admin should see button to merge articles
  When I am logged into the admin panel as "admin"
  And I am on the Edit page
  Then I should see "Merge Articles"

# a better test would be to look at the Edit page for an article that the blog publisher owns
Scenario: Blog publisher should NOT see button to merge articles
  When I am logged into the admin panel as "blog_publisher"
  And I am on the Edit page
  Then I should see "Error, you are not allowed to perform this action"
  Then I should not see "Merge Articles"

#Scenario: Contributor should NOT see button to merge articles
#  And I am logged into the admin panel as "contributor"
#  And I am on the Edit page
#  Then I should see "Error, you are not allowed to perform this action"
#  Then I should not see "Merge Articles"

# unfortunately article ids are a bit weird
# by default this edits the article with id = 3
Scenario: When articles are merged, the merged article should contain the text of both previous articles
  When I am logged into the admin panel as "admin"
  And I am on the Edit page 
  And I fill in "merge_with" with "4" 
  And I press "Merge"
  Then I should see "text of article 1"
  And I should see "text of article 2"
  And "text of article 1" should appear before "text of article 2"

Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article
  When I am logged into the admin panel as "admin"
  And I am on the Edit page 
  And I fill in "merge_with" with "4" 
  And I press "Merge"
  When I go to the home page
  Then use debugger
  And I follow "Article1"
  Then I should see "Article1"
  And I should see "text of comment 2"
  And I should see "text of comment 3"
  And I should see "text of comment 4"

#Scenario: When articles are merged, the merged article should contain the text of both previous articles
#  Given I am logged in as Admin
#  And on the Edit page for Article1
#  And I enter the Article ID for Article2 in the "merge_with" field
#  And I click the Merge button
#  Then I should be on the merged article page
#  And I should see the body from Article1 and Article2
#  And the author should be Author1
#  And the title should be from Article1
#  And comments on each of the two original articles need to all carry over and point to the new, merged article
