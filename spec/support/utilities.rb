include ApplicationHelper
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



#utilities for authentication_pages_spec
def valid_signin(user)
	fill_in "Email",	with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
end


RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert-error', text: message)
	end
end


