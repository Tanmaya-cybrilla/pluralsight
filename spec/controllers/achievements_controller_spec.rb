require "rails_helper"

describe AchievementsController do

  describe "GET index" do

    it "renders :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns only public achievement to template" do
      public_achievement = FactoryGirl.create(:public_achievement)
      private_achievement = FactoryGirl.create(:private_achievement)
      get :index
      expect(assigns(:achievements)).to match_array([public_achievement])
    end
  end

  describe "GET edit" do

    let(:achievement) { FactoryGirl.create(:public_achievement) }

    it "render :edit template" do
      get :edit, id: achievement
      expect(response).to render_template(:edit)
    end

    it "assigns the requested achievement to template" do
      get :edit, id: achievement
      expect(assigns(:achievement)).to eq(achievement)
    end
  end 

  describe "GET new" do

    it "renders :new template" do
      get :new
      expect(response).to render_template :new
    end

    it "assigns new Achievement to @achievement" do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  describe "GET show" do

    let(:achievement) { FactoryGirl.create(:public_achievement) }
    it "render :show template" do
      get :show, id: achievement
      expect(:response).to render_template(:show)
    end

    it "assigns requested achievement to @achievement" do
      get :show, id: achievement
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe "POST create" do
    context "valid data" do

      let(:valid_data) { FactoryGirl.attributes_for(:public_achievement) }
      it "redirects to achievements#show" do
        post :create, achievement: valid_data
        expect(response).to redirect_to(achievement_path(assigns[:achievement]))
      end

      it "creates new achievement in database" do
        expect{
          post :create, achievement: valid_data
        }.to change(Achievement, :count).by(1)
      end
    end

    context "Invalid data" do

      let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: ' ') }
      it "renders new template" do
        post :create, achievement: invalid_data
        expect(response).to render_template :new
      end

      it "creates new achievement in database"  do
        expect{
          post :create, achievement: invalid_data
        }.not_to change(Achievement, :count)
      end
    end
  end

  describe "Put data" do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    context "valid data" do
      let(:valid_data) { FactoryGirl.create(:public_achievement, title: "New Title")}

      it "redirects to achievement#show" do
        put :update, id: achievement, achievement: valid_data.as_json
        expect(response).to redirect_to(achievement)
      end

      it "updates achievement in the databse" do
        put :update, id: achievement, achievement: valid_data.as_json
        achievement.reload
        expect(achievement.title).to eq ("New Title")
      end
    end

    context "invalid data" do
      
      let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: "", description: 'new')}
      
      it "renders :edit template" do
        put :update, id: achievement, achievement: invalid_data
        expect(response).to render_template(:edit)
      end

      it "doesn't save invalid data in the database" do
        put :update, id: achievement, achievement: invalid_data
        achievement.reload
        expect(achievement.title).not_to eq("new")
      end
    end
  end

  describe "DELETE destroy" do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    it "redirects to achievements#index" do
      delete :destroy, id: achievement
      expect(response).to redirect_to(achievements_path)
    end

    it "deletes achievements from database" do
      delete :destroy, id: achievement
      expect(Achievement.exists?(achievement.id)).to be_falsy
    end
  end
end