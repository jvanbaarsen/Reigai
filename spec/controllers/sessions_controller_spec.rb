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
      it 'logs the user in' do
        user = User.new
        @controller.stub(:login)
        @controller.current_user = user
        post :create, email: user.email, password: 'secret'
        expect(@controller.current_user).to eq(user)
      end
      it 'redirects to the root path' do
        @controller.stub(:login).and_return true
        post :create, email: 'info@example.com', password: 'secret'
        expect(response).to redirect_to root_path
      end

      it 'sets a flash notice' do
        @controller.stub(:login).and_return true
        post :create, email: 'info@example.com', password: 'secret'
        expect(flash[:notice]).to eq('Signed in')
      end
    end

    context 'When information is invalid' do
      it 'renders the :new template' do
        @controller.stub(:login).and_return false
        post :create, email: 'Super invalid', password: 'Even more invalid'
        expect(response).to render_template :new
      end

      it 'sets a flash error' do
        @controller.stub(:login).and_return false
        post :create, email: '--', password: '--'
        expect(flash[:error]).to eq('Email or password was invalid')
      end
    end
  end

  context '#destroy' do
    it 'logs a user out' do
      @controller.current_user = User.new
      get :destroy
      expect(@controller.current_user).to be_false
    end

    it 'redirects back to the login path' do
      @controller.current_user = User.new
      @controller.stub(:logout)
      get :destroy
      expect(response).to redirect_to login_path
    end
  end
end
