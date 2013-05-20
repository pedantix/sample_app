class Users < ActiveRecord::Base
	attr_accessible :new

	default_scope order: 'microposts.created_at DESC'
end
