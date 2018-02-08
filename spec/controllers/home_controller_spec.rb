describe HomeController, :type => :controller do
  render_views

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create (:user)
    sign_in @user

  end    

  describe 'GET #index' do
        
    it 'renders signed_out home index partials when @user is signed_out' do
      sign_out @user
      get :index
      expect(response).to render_template(:index)
      expect(response).to render_template(partial: 'home/_welcome')
    end
    
    it 'renders signed_in home index partials when @user is signed_in' do
      get :index
      expect(response).to render_template('home/index')
      expect(response).to render_template(partial: 'home/_automation_tasks')
    end

  end

end