require 'rails_helper'

feature 'User can sign out', %q{
  I'd like to be able to sign out
} do
  given(:user) { create(:user) }

  scenario 'Registred user tries to sign out' do
    sign_in(user)

    click_on 'Log out'
    save_and_open_page
    expect(page).to have_content 'Signed out successfully.'
  end
end