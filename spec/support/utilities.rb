include ApplicationHelper
include UsersHelper

def full_title(page_title)
	base_title = "Ruby on Rails Tutorial Sample App"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end


#general utility like title
RSpec::Matchers.define :have_title_content do |content|
	match do |page|
		page.should have_selector('title', text: content)
	end
end

RSpec::Matchers.define :have_h1_content do |content|
	match do |page|
		page.should have_selector('h1', text: content)
	end
end

#utilities for authentication_pages_spec
def sign_in(user)
	visit signin_path
	fill_in "Email",	with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
	#Sign in when not using Capybara as well.
	cookies[:remember_token] = user.remember_token
end


RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert-error', text: message)
	end
end

RSpec::Matchers.define :have_success_message do |message|
	match do |page|
		page.should have_selector('div.alert-success', text: message)
	end
end

#utitilites for user_pages_spec



