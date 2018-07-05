require 'rails_helper'

RSpec.feature 'user visits homepage, enters credentials' do
  scenario 'logs in using omniauth' do
    stub_omniauth

    visit root_path
    expect(page).to have_link("Sign in with GitHub")
    click_link "Sign in with GitHub"
    expect(page).to have_content("John Livingston")
    expect(page).to have_content("Logout")
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({

    })
  end
end