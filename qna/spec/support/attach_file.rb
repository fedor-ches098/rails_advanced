module AttachFile
  def attach_file_to(model)
    model.files.attach(io: File.open("#{Rails.root.join('spec/rails_helper.rb')}"), filename: 'rails_helper.rb')
  end
end

RSpec.configure do |config|
  [:controller, :feature].each do |type|
    config.include AttachFile, type: type
  end
end