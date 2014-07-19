require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should have_many(:user_friendships)
	should have_many(:friends)

	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have unique profile name" do
		user = User.new
		user.profile_name = users(:rickson).profile_name

		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Mini', last_name: 'Goh', email: 'minigoh@gmail.com')
		user.password = user.password_confirmation = '12345678'
		
		user.profile_name = "My Profile with Spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly.")

	end
	
	test "a user can have correctly formatted profile_name" do
		user = User.new(first_name: 'Mini', last_name: 'Goh', email: 'minigoh1@gmail.com')
		user.password = user.password_confirmation = '12345678'

		user.profile_name = 'Mini_1'
		assert user.valid?
	end

	test "that no error is raised when trying to access a friends list" do
		assert_nothing_raised do
			users(:rickson).friends
		end
	end

	test "that creating friendship on user works" do
		users(:rickson).friends << users(:garygoh)
		users(:rickson).friends.reload
		assert users(:rickson).friends.include?(users(:garygoh))
	end

end
