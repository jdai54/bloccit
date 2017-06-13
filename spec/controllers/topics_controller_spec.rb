require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  # #8 create a topic and assign it to "my_topic" using "let". We use RandomData to give "my_topic" a random name and description
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_topic to @topics" do
      get :index
# #9 because our test created one topic ([my_topic]), we expect "index" to return an array of one item. We use "assigns", a method in "ApplicationController::TestCase". "assigns" gives the test access to "instance variables assigned in the acton that are available for the view"
      expect(assigns(:topics)).to eq([my_topic])
    end
  end
# #16 pass {id: my_topic.id} to "show" as a parameter. These parameters are passed to the "params" hash whic contains all parameters passed to the applications controller (application_controller.rb), whether from GET, POST, or any other HTTP action
  describe "GET show" do
    it "returns http success" do
      get :show, {id: my_topic.id}
      expect(response).to have_http_status(:success)
    end
# #17 expect the "response" to return the show view using the render_template matcher
    it "renders the #show view" do
      get :show, {id: my_topic.id}
      expect(response).to render_template :show
    end

    it "assigns my_topic to @topic" do
      get :show, {id: my_topic.id}
      expect(assigns(:topic)).to eq(my_topic)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "initializes @topic" do
      get :new
      expect(assigns(:topic)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of topics by 1" do
      expect{ post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}}.to change(Topic,:count).by(1)
    end

    it "assigns Topic.last to @topic" do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
      expect(assigns(:topic)).to eq Topic.last
    end

    it "redirects to the new topic" do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
      expect(response).to redirect_to Topic.last
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_topic.id}
      expect(response).to render_template :edit
    end

    it "assigns topic to be updated to @topic" do
      get :edit, {id: my_topic.id}
      topic_instance = assigns(:topic)

      expect(topic_instance.id).to eq my_topic.id
      expect(topic_instance.name).to eq my_topic.name
      expect(topic_instance.description).to eq my_topic.description
    end
  end

  describe "PUT update" do
    it "updates topic with expected attributes" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_paragraph

      put :update, id: my_topic.id, topic: { name: new_name, description: new_description }

      updated_topic = assigns(:topic)
      expect(updated_topic.id).to eq my_topic.id
      expect(updated_topic.name).to eq new_name
      expect(updated_topic.description).to eq new_description
    end

    it "redirects to the updated topic" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_paragraph

      put :update, id: my_topic.id, topic: { name: new_name, description: new_description }
      expect(response).to redirect_to my_topic
    end
  end

  describe "DELETE destroy" do
    it "deletes the topic" do
      delete :destroy, {id: my_topic.id}
      count = Post.where({id: my_topic.id}).size
      expect(count).to eq 0
    end

    it "redirects to topics index" do
      delete :destroy, {id: my_topic.id}
      expect(response).to redirect_to topics_path
    end
  end
end
