module UsersHelper

	#returns the gravatar (gravatar.com) for the given user
	def gravatar_for ( user )
		gravatar_id = Digest::MD5::hexdigest(user.email.strip.downcase)
		gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?d=identicon"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
