require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest

    test "that /login route open the login page" do 
   	get '/login'
   	assert_response :success
		
	end

	test "that /logout route open the logout page" do 
   	get '/logout'
   	assert_response :redirect
   	assert_redirected_to '/'
		
	end

	test "that /register route open the register page" do 
   	get '/register'
   	assert_response :success
		
	end

end
