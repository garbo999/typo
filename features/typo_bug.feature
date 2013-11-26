Feature: Manage categories
  As an author/admin user
  In order to distinguish different content
  I want to be have categories for articles

Background: Users, articles and comments in database

  Given the blog is set up for CS169.2x

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

#Scenario: Use debugger
#  Then use debugger

Scenario: Admin should see page to create/edit categories
  When I am logged into the admin panel as "admin"
  And I follow "Categories"
  And I follow "General"
  Then I should see "Your category slug. Leave empty if you don't know what to put here"
  And the form field "category_name" should be prefilled with "General"
  #Then use debugger

Scenario: Admin should be able to create new category
  When I am logged into the admin panel as "admin"
  And I follow "Categories"
  Then I should see "Your category slug. Leave empty if you don't know what to put here"
  #And the form field "category_name" should be prefilled with "nil"
  And I fill in "category_name" with "test cat 1"
  And I fill in "category_keywords" with "key1, key2"
  And I press "Save"
  Then I should see "test cat 1"
  And I should see "key1, key2"
