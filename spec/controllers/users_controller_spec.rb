require 'spec_helper'

describe UsersController do
  context '#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
    it 'creates a new user object, and assigns it' do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  context '#create' do
    context 'with valid information' do
      it 'creates a user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it 'redirects to the login path' do
        User.any_instance.stub(:save).and_return true
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to login_path
      end
    end

    context 'with invalid information' do
      it 'renders the new template' do
        User.any_instance.stub(:save).and_return false
        post :create, user: FactoryGirl.attributes_for(:user, email: '')
        expect(response).to render_template :new
      end
    end
  end
end
