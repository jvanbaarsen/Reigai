require 'spec_helper'

feature 'Create an application' do
  scenario 'has valid information' do
    create_application
    expect(page).to have_content('Your application has been created')
    expect(current_path).to eq(application_path(Application.last))
    expect(user.applications).to include(Application.last)
  end
end

feature 'Created applications should be listed in the top menu' do
  scenario 'When there are applications' do
    app = create_application
    expect(find('.applications-menu')).to have_link(app.name)
  end
end

private
def create_application
  application = FactoryGirl.build(:application)
  create_application_with({
    name: application.name
  })
  return application
end
def create_application_with(values)
  login_user(user)
  visit create_application_path
  fill_in "application_name", with: values[:name]
  click_button "Create application"
end

def user
  @user ||= FactoryGirl.create(:user)
end
