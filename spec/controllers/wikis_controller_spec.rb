require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do

    let(:my_user)  { create(:user) }
    let(:my_wiki)  { create(:wiki, user: my_user) }

    before(:each) do
      sign_in my_user
    end

    context "member doing CRUD action on wikis" do

    describe "GET #show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET #new" do
      it "returns http status succss" do
        get :new, wiki_id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new, wiki_id: my_wiki.id
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new, wiki_id: my_wiki.id
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, wiki: {title: 'WikiTestTitle', body: 'WikiTestBody'} }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: 'WikiTestTitle', body: 'WikiTestBody'}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: 'WikiTestTitle', body: 'WikiTestBody'}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: my_wiki.id
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, id: my_wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = 'WikiTestTitle'
        new_body = 'WikiTestBody'

        put :update, id: my_wiki.id, wiki: {title: 'WikiTestTitle', body: 'WikiTestBody'}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = 'WikiTestTitle'
        new_body = 'WikiTestBody'

        put :update, id: my_wiki.id, wiki: {title: 'WikiTestTitle', body: 'WikiTestBody'}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_wiki.id
        count = Wiki.where({id: my_wiki.id}).count
        expect(count).to eq 0
      end

      it "redirects to the wiki index view" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to wikis_path
      end
    end
  end
end
