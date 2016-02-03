require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do

  let(:my_user)       { create(:user) }
  let(:premium)       { create(:user, role: 'premium')}
  let(:my_wiki)       { create(:wiki) }
  let(:private_wiki)  { create(:wiki, private: true)}
  let(:collaborator)  { create(:collaborator, wiki_id: my_wiki.id, user_id: my_user.id) }

  before(:each) do
    sign_in my_user
  end

  describe "POST create" do
    it "increases the number of Collaborator by 1" do
      expect{ post :create, wiki_id: my_wiki.id, user_id: my_user.id, collaborator: {}}.to change(Collaborator,:count).by(1)
    end

    it "assigns the new post to @collaborator" do
      post :create, wiki_id: my_wiki.id, user_id: my_user.id, collaborator: {}
      expect(assigns(:collaborator)).to eq Collaborator.last
    end

    it "redirects to wiki show view" do
      post :create, wiki_id: my_wiki.id, user_id: my_user.id, collaborator: {}
      expect(response).to redirect_to [my_wiki]
    end
  end

  describe "DELETE destroy" do
    it "returns http redirect" do
      delete :destroy, wiki_id: my_wiki.id, id: collaborator.id
      count = Collaborator.where({id: collaborator.id}).count
      expect(count).to eq 0
    end

    it "redirects to the wiki index view" do
      delete :destroy, wiki_id: my_wiki.id, id: collaborator.id
      expect(response).to redirect_to my_wiki
    end
  end
end
