module FeatureHelpers
  OmniAuth.config.test_mode = true
  
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def attach_files
    attach_file 'File', [
      Rails.root.join('spec/rails_helper.rb'),
      Rails.root.join('spec/spec_helper.rb')
    ].map(&:to_s)
  end

  def add_image_to(badge)
    badge.image.attach(
      io: File.open(Rails.root.join('app/assets/images/badges/default.png').to_s),
      filename: 'default.rb'
    )
  end
end