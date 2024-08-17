require 'rails_helper'

feature 'User can register', %q{
  I'd like to be able to register
} do

  given(:user) { create(:user) }

  background { visit new_user_registration_path }
  scenario 'User tries to register' do
    visit new_user_registration_path
    
    fill_in 'Email', with: 'user@domain.com'
    fill_in 'Password', with: 'userpassword'
    fill_in 'Password confirmation', with: 'userpassword'

    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User tries to register with black params' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''

    click_button 'Sign up'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'User tries to register with diff passwords' do
    fill_in 'Email', with: 'user@domain.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '87654321'
    click_button 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'User tries to register with existed email' do 
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content 'Email has already been taken'
  end
end