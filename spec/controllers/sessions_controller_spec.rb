require 'spec_helper'
describe SessionsController do
  context '#new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  context '#create' do
    context 'When valid information is given' do
      let(:user) {FactoryGirl.create(:user)}
      it 'logs the user in' do
        post :create, email: user.email, password: 'secret'
        expect(@controller.current_user).to eq(user)
      end
      it 'redirects to the root path' do
        post :create, email: user.email, password: 'secret'
        expect(response).to redirect_to root_path
      end

      it 'sets a flash notice' do
        post :create, email: user.email, password: 'secret'
        expect(flash[:notice]).to eq('Signed in')
      end
    end

    context 'When information is invalid' do
      it 'renders the :new template' do
        post :create, email: 'Super invalid', password: 'Even more invalid'
        expect(response).to render_template :new
      end

      it 'sets a flash error' do
        post :create, email: '--', password: '--'
        expect(flash[:error]).to eq('Email or password was invalid')
      end
    end
  end

  context '#destroy' do
    before(:each) {login_user(FactoryGirl.create(:user))}
    it 'logs a user out' do
      get :destroy
      expect(@controller.current_user).to be_false
    end

    it 'redirects back to the login path' do
      get :destroy
      expect(response).to redirect_to login_path
    end
  end
end
