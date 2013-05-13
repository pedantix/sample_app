#a file for factory methods from factory girl

FactoryGirl.define do
	factory :user do
		name		"Shaun Hubbard"
		email		"shaun.hubbard@reasonandmadness.com"
		password	"foobar"
		password_confirmation "foobar"
	end
end