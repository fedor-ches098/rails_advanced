require 'rails_helper'

feature 'User can create answer', %q{
  As an authenticated user
  being on the question page
  I'd like to create the answer to the question
} do
  
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user' do

    background do 
      sign_in(user)
      visit question_path(question)
    end

    scenario 'reply a answer' do
      fill_in 'Body', with: 'test answer'
      click_on 'Reply'
      save_and_open_page
      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'test answer'
    end

    scenario 'reply a answer with errors' do 
      click_on 'Reply'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer a question' do 
    visit question_path(question)
    click_on 'Reply'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end