require 'spec_helper'
describe ApplicationsController do
  before(:each) {login_user(user)}
  describe '#new' do
    it 'renders the :new template' do
      get :new
      response.should render_template :new
    end
  end

  describe '#create' do
    context 'with valid information' do
      it 'creates a new application' do
        expect {
          create_application
        }.to change(Application, :count).by(1)
      end

      it 'redirects to the new application' do
        create_application
        expect(response).to redirect_to Application.last
      end

      it 'subscribes the current user to the application' do
        create_application
        expect(current_user.applications.last).to eq(Application.last)
      end
    end

    context 'with invalid information' do
      it 'renders the :new template' do
        post :create, application: FactoryGirl.attributes_for(:application, name: '')
        expect(response).to render_template :new
      end
    end
  end
end

def user
  @user ||= FactoryGirl.create(:user)
end

def create_application
  post :create, application: FactoryGirl.attributes_for(:application)
end
