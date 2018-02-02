describe SearchesController, :type => :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]

    @user = create (:user)
    sign_in @user

    @search_available = FactoryBot.build(:search, user_id: @user.id)
    @search_taken = FactoryBot.build(:search, term: 'tester')
  end

  describe 'GET #index' do
    it "renders the index template" do
    get :index
      expect(response).to render_template('searches/index')
    end
  end

  describe "POST #create" do
    #TODO: specific successs/fail tests checking response body for "is available", and others 
    xit 'redirects when searching for an available term' do
      post :create, params: { search: { term: @search_available.term, user_id: @search_available.user_id } }
      expect(assert_response(:redirect)).to be(true)
    end

    xit 'fails and doesn\'t write to the db with a taken term' do
    expect {
      post "/contacts", { contact: contact_attributes }
    }.to_not change(Contact, :count)
    end

    xit 'fails a new search and fails to save to the db when a search is made for an taken term' do
      begin
        search = { term: "tester", user_id: @user.id } 
        post :create, params: { search: search }
        assert_response(:redirect)
      # Rescue for 404 Not Found
      rescue OpenURI::HTTPError
        expect(false).to be false
      end      
    end

    xit 'rejects an invalid search' do
        search = { term: "te", user_id: @user.id } 
        post :create, params: { search: search }
        assert_response(:redirect)
    end    
  end

  describe 'GET #new' do

    xit '' do
      
    end

  end

  describe 'GET #edit' do

    xit '' do
      
    end

  end

  describe "GET #show" do

    xit '' do
      
    end
    
  end

  describe 'PATCH #update' do

    xit '' do
      
    end
    
  end

  describe 'PUT #update' do

    xit '' do
      
    end

  end

  describe 'DELETE #delete' do

    xit '' do
      
    end

  end

end