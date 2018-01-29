# describe UsersController do
#   describe “GET index” do
#     it “assigns @users” do
#       user = FactoryGirl.create(:user)
#       get :index
#       expect(assigns(:users)).to eq([user])
#     end
#     it “renders the index template” do
#       get :index
#       expect(response).to render_template(“index”)
#     end
#   end
#   describe “GET #show” do
#     it “renders the #show view” do
#       get :index, {id:user.id}
#       response.should render_template :show
#     end
#   end
#  end
# end


describe SearchesController, :type => :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create (:user)
    sign_in @user
  end    

  describe 'GET #index' do
    it "renders the index template" do
    get :index
      expect(response).to render_template(:index)
    end
  end

  # describe 'GET #new' do
    
  # end


  # describe "POST #create" do
    
  # end
end