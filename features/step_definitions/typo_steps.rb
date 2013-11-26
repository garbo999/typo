Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create(article)
  end
end

Given /the following comments exist/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create(comment)
  end
end

Then /use debugger/ do
  print Article.all
  #print User.all
  #print Comment.all
  save_and_open_page
end

Given /^the blog is set up for CS169.2x$/ do
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  User.create!({:login => 'admin',
                :password => 'aaaaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 1,
                :name => 'admin',
                :state => 'active'})
  User.create!({:login => 'blog_publisher',
                :password => 'aaaaaaaa',
                :email => 'blog_publisher@snow.com',
                :profile_id => 2,
                :name => 'blog_publisher',
                :state => 'active'})
  User.create!({:login => 'contributor',
                :password => 'aaaaaaaa',
                :email => 'contributor@snow.com',
                :profile_id => 3,
                :name => 'contributor',
                :state => 'active'})
end

And /^I am logged into the admin panel as "([^"]*)"$/ do |user_type|
  visit '/accounts/login'
  fill_in 'user_login', :with => user_type
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Then /^"(.*?)" should appear before "(.*?)"$/ do |arg1, arg2|
  page.body.should =~ /#{arg1}.*#{arg2}/m
end

Then /^the form field "(.*?)" should be prefilled with "(.*?)"$/ do |arg1, arg2|
  find_field(arg1).value.should eq arg2
end

