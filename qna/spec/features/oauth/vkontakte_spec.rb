require 'rails_helper'

feature 'User can sign in with vkontakte' do
  describe 'User signs in with Vkontakte' do
    given!(:user) { create(:user) }

    background { visit new_user_session_path }

    describe 'login with vkontakte' do
      scenario 'existing user' do
        mock_auth :vkontakte

        click_on 'Sign in with Vkontakte'

        fill_in 'Email', with: user.email
        click_on 'save'

        expect(page).to have_content 'You can sign in by provider'
      end

      scenario 'does not existing user' do
        mock_auth :vkontakte
        click_on 'Sign in with Vkontakte'
        fill_in 'Email', with: 'new@gmail.com'
        click_on 'save'
        open_email 'new@gmail.com'
        current_email.click_link 'Confirm my account'

        expect(page).to have_content 'Your email address has been successfully confirmed'

        visit new_user_registration_path
        click_on 'Sign in with Vkontakte'

        expect(page).to have_content 'Successfully authenticated from Vkontakte account.'
      end
    end
  end
end