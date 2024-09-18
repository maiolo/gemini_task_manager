# spec/controllers/api/v1/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: 'Task Title', status: 'pending' } }
  let(:invalid_attributes) { { title: nil, status: nil } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json
      expect(response).to be_successful
    end

    it 'returns a list of tasks for the current user' do
      task1 = create(:task, user: user)
      task2 = create(:task, user: user)
      get :index, format: :json
      expect(assigns(:tasks)).to match_array([task1, task2])
    end
  end

  describe 'GET #show' do
    let(:task) { create(:task, user: user) }

    it 'returns a success response' do
      get :show, params: { id: task.to_param }, format: :json
      expect(response).to be_successful
    end

    it 'returns the correct task' do
      get :show, params: { id: task.to_param }, format: :json
      expect(assigns(:task)).to eq(task)
    end

    it 'returns 404 if task not found' do
      get :show, params: { id: 0 }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new task' do
        expect {
          post :create, params: { task: valid_attributes }, format: :json
        }.to change(Task, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: { task: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
      end

      it 'assigns the created task as @task' do
        post :create, params: { task: valid_attributes }, format: :json
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end

      it 'associates the task with the current user' do
        post :create, params: { task: valid_attributes }, format: :json
        expect(assigns(:task).user).to eq(user)
      end
    end

    context 'with invalid params' do
      it 'does not create a new task' do
        expect {
          post :create, params: { task: invalid_attributes }, format: :json
        }.to change(Task, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: { task: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:task) { create(:task, user: user) }

    context 'with valid params' do
      let(:new_attributes) { { title: 'Updated Task Title', status: 'in_progress' } }

      it 'updates the requested task' do
        put :update, params: { id: task.to_param, task: new_attributes }, format: :json
        task.reload
        expect(task.title).to eq('Updated Task Title')
        expect(task.status).to eq('in_progress')
      end

      it 'returns a success response' do
        put :update, params: { id: task.to_param, task: new_attributes }, format: :json
        expect(response).to be_successful
      end

      it 'assigns the requested task as @task' do
        put :update, params: { id: task.to_param, task: new_attributes }, format: :json
        expect(assigns(:task)).to eq(task)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        put :update, params: { id: task.to_param, task: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create(:task, user: user) }

    it 'destroys the requested task' do
      expect {
        delete :destroy, params: { id: task.to_param }, format: :json
      }.to change(Task, :count).by(-1)
    end

    it 'returns a no content response' do
      delete :destroy, params: { id: task.to_param }, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
