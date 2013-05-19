#a file for factory methods from factory girl

FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n|	"Shaun Hubbard_#{n}" }
		sequence(:email) { |n|	"shaun.hubbard_#{n}@reasonandmadness.com" }
		password	"foobar"
		password_confirmation "foobar"
		factory :admin do
			admin true
		end
	end
end