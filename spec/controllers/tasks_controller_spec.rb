describe TasksController, :type => :controller do
  render_views

  describe 'POST #new_test_account' do
      
    it 'creating a new test account makes a new User objects and redirects' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create (:user)
      sign_in @user
      last_before = User.last
      post :new_test_account
      last_after = User.last
      expect(last_before.object_id === last_after.object_id).to be(false)
      expect(assert_response(:redirect)).to be(true)
    end

  end

  describe 'POST #sign_in_as_new_test_account' do
      
    xit '' do

    end
    
    xit '' do

    end

  end

  describe 'POST #remove_latest_test_account' do
      
    it 'deleting the newest test account changes the latest User object' do
      last_before = User.count
      post :remove_latest_test_account
      last_after = User.count
      expect(last_before != last_after)
    end
    
    xit '' do

    end

  end

end