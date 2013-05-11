module UsersHelper

	#returns the gravatar (gravatar.com) for the given user
	def gravatar_for ( user )
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "http://www.gravatar.com/avatars/#{gravatar_id}.png"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
