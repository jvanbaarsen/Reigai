require 'spec_helper'

describe UsersController do
  context '#new' do
    before(:each) {get :new}
    it 'renders the :new template' do
      expect(response).to render_template :new
    end
    it 'creates a new user object, and assigns it' do
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
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to login_path
      end
    end

    context 'with invalid information' do
      it 'renders the new template' do
        post :create, user: FactoryGirl.attributes_for(:user, email: '')
        expect(response).to render_template :new
      end
    end
  end
end
