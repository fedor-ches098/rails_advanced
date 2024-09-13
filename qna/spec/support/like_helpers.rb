module LikeHelpers
  def liked(model, user)
    if model.to_s == 'Answer'
      question = create(:question, user: user)
      create(model.to_s.underscore.to_sym, question: question, user: user)
    else
      create(model.to_s.underscore.to_sym, user: user)
    end
  end
end

RSpec.configure do |config|
  [:controller, :model].each do |type|
    config.include LikeHelpers, type: type
  end
end