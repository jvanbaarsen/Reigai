require 'spec_helper'

feature 'Create a product' do
  scenario 'With valid information' do
    application = FactoryGirl.build(:application)
    create_application_with({
      name: application.name
      })
    expect(page).to have_content('Your application has been created')
    expect(current_path).to eq(application_path(Application.last))
  end

  def create_application_with(values)
    login_user(FactoryGirl.create(:user))
    visit create_application_path
    fill_in "application_name", with: values[:name]
    click_button "Create application"
  end
end