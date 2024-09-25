FactoryBot.define do
  sequence :title do |n|
    "Title #{n}"
  end

  sequence :body do |n|
    "Body #{n}"
  end

  factory :question do
    title
    body
    user


    factory :question_with_file do
      after(:create) do |question|
        question.files.attach(io: File.open(Rails.root.join("app", "assets", "images", "badges","default.png")), filename: 'default.png',
                              content_type: 'image/png')
      end
    end
  end

  trait :invalid_question do
    title { nil }
    body { nil }
  end
end
