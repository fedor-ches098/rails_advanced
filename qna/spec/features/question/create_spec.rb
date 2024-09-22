require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from a comunity
  As an authenticated user
  I'd like to be able to ask the question
} do
  given(:user) { create(:user) }

  describe 'Authenticated user' do

    background do 
      sign_in(user)
      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text'
    end

    scenario 'asks a question with errors' do 
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asc question with attach files' do
      fill_in 'Title', with: 'Question title'
      fill_in 'Body', with: 'Question body'

      attach_file 'File', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb').to_s}"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'ask question with badge' do
      fill_in 'Title', with: 'Question title'
      fill_in 'Body', with: 'Question body'

      fill_in 'Badge title', with: 'Very best answer'
      attach_file 'Image', Rails.root.join('app/assets/images/badges/default.png').to_s

      click_on 'Ask'
      
      expect(page).to have_css("img[src*='default.png']")
    end
  end

  context 'mulitple sessions', js: true do
    scenario "question appears on another user's page" do
      Capybara.using_session('second_user') do
        second_user = create(:user)

        sign_in(second_user)
        visit questions_path
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path

        click_on 'Ask question'
        fill_in 'Title', with: 'Question title'
        fill_in 'Body', with: 'Question body'
        click_on 'Ask'

        expect(page).to have_content 'Question title'
        expect(page).to have_content 'Question body'
      end

      Capybara.using_session('second_user') do
        expect(page).to have_content 'Question title'
      end
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do 
    visit questions_path
    expect(page).to_not have_link 'Ask question'
  end
end