FactoryBot.define do
  factory :link do
    name { "Thinknetica" }
    url { "http://thinknetica.com" }
  end

  trait :gist_link do
    name { "Gist" }
    url { "https://gist.github.com/fedor-ches098/52c13384c661b3bc5b0e5ed494db3b68" }
  end
end
