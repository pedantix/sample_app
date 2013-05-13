module UsersHelper

	#returns the gravatar (gravatar.com) for the given user
	def gravatar_for ( user, options = {size:40} )
		gravatar_id = Digest::MD5::hexdigest(user.email.strip.downcase)
		gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=" +
						options[:size].to_s
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
