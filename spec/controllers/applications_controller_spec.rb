require 'spec_helper'
describe ApplicationsController do
  before(:each) {login_user(FactoryGirl.create(:user))}

  context '#show' do
    let(:user) {@controller.current_user}
    let(:application) {FactoryGirl.create(:application)}
    it 'renders the :show template' do
      user.subscribe(application)
      get :show, id: application.id
      expect(response).to render_template :show
    end

    it 'finds the application given to it when the user is subscribed' do
      user.subscribe(application)
      get :show, id: application.id
      expect(assigns(:application)).to eq(application)
    end

    it 'throws a 404 when the given application cant be found' do
      expect do
        get :show, id: 'unknown'
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'throws a 404 when the current user is not subscribed for the given application' do
      expect do
        get :show, id: application.id
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context '#new' do
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
        expect(@controller.current_user.applications.last).to eq(Application.last)
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

def create_application
  post :create, application: FactoryGirl.attributes_for(:application)
end
