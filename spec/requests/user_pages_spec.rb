require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: 'Sign up') }
		it { should have_selector('title', text: full_title('Sign up'))}
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name)}
	end

	describe "signup" do
		before { visit signup_path }

		let(:submit) { "Create my account" }
		
		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				let(:blankUser) { User.new }
				before { click_button submit }

				it  { should have_selector('title', text:'Sign up')}
				it  { should have_content('error') }

				before { blankUser.save }
				it { should  have_content('The form contains ') } 
				it { should  have_content( (blankUser.errors.count - 1 ).to_s ) } 

				let(:index) { 0 } #select out the first error messages regarding digest, sans hack
				let(:errorArray) { blankUser.errors.full_messages.select { (index + 1) > 1} }

				it "should contain all any errors" do
					errorArray.should be_all {|n| should have_content(n)}
				end
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",			with: "Example User"
				fill_in "Email",		with: "user@example.com"
				fill_in "Password",		with: "foobar"
				fill_in "Confirmation",	with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) {User.find_by_email("user@example.com")}

				it { should have_selector('title', text: user.name)}
				it { should have_selector('div.alert.alert-success', text: 'Welcome')}
			end
		end
	end
end
