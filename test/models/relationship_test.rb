require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

	def setup
		@relationship = Relationship.new(follower_id: users(:ff4c00).id, followed_id: users(:bad_guy).id)
	end 

	test '非空测试' do
		assert @relationship.valid?
		@relationship.follower_id = nil
		assert_not @relationship.valid?
		setup
		@relationship.followed_id = nil
		assert_not @relationship.valid?
	end

end

