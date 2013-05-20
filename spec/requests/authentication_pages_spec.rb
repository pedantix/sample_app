require 'spec_helper'

describe "Authentication" do

	subject{ page }

	describe "signin page" do
		before { visit signin_path }

		it {should have_selector('h1',	text: 'Sign in') }	
		it {should have_title_content('Sign in') } 

		describe "with invalid information" do
			let(:user) { FactoryGirl.create(:user) }
			before { click_button "Sign in" }

			it { should have_title_content('Sign in') }
			it { should have_error_message('Invalid')}
		
			it { should_not have_title_content( user.name ) }
			it { should_not have_link('Users', href: users_path )}
			it { should_not have_link('Profile', href: user_path(user)) }
			it { should_not have_link('Settings', href: edit_user_path(user) ) }
			it { should_not have_link('Sign out', href: signout_path ) }


			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_error_message('Invalid') }
			end
		end
		
		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }

			before { sign_in( user ) }

			it { should have_title_content( user.name ) }
			it { should have_link('Users', href: users_path )}
			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Settings', href: edit_user_path(user) ) }
			it { should have_link('Sign out', href: signout_path ) }

			it { should_not have_link('Sign in', href: signin_path)}
			it { should_not have_selector('button', text: 'Sign up') }

			describe "followed by signout" do
				before { click_link "Sign out" }
				it {should have_link('Sign in') }
			end
		end 

		describe "authorization" do

			describe "for non signed-in-users" do
				let(:user) { FactoryGirl.create(:user) }
				
				describe "when attempting to visit a protected page" do
					before do
						visit edit_user_path(user)
						sign_in(user)
					end

					describe "after signing in" do
						it "should render the desired protected page" do
							page.should have_title_content('Edit user')
						end
					end

					describe "forwarding should not happen twice" do
						before do
							sign_out
							sign_in(user)
						end 
						it { should_not have_title_content('Edit user') }
					end
				end
			end

			let(:user) { FactoryGirl.create(:user) }

			describe "in the Users controller" do
				before { visit edit_user_path(user) }
				it { should have_title_content('Sign in') }
			end

			describe "visiting the user index" do
				before { visit users_path }
				it { should have_title_content('Sign in') }
			end

			describe "submitting to the update action" do
				before { put user_path(user) }
				specify { response.should redirect_to(signin_path) }
			end


			describe "as wrong user" do
				let(:user) { FactoryGirl.create(:user) }
				let(:wrong_user) { FactoryGirl.create(:user, email:"wrong@example.com") }
				before{ sign_in user }

				describe "visiting Users#edit page" do
					before { visit edit_user_path(wrong_user) }
					it { should_not have_title_content('Edit user') }
				end

				describe "submitting a PUT request to the Users#update action" do
					before { put user_path(wrong_user) }
					specify { response.should redirect_to(root_path) }
				end
			end

			describe "as non-admin user" do
				let(:user) { FactoryGirl.create(:user) }
				let(:non_admin) {FactoryGirl.create(:user) }

				before {sign_in non_admin}

				describe "submitting a DELETE requet to the Users#destroy action" do
					before { delete  user_path(user) }
					specify { response.should redirect_to(root_path) } 
				end
			end
		end
	end
end
