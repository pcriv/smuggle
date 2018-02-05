FactoryBot.define do
  factory :user do
    skip_create

    name { Faker::RickAndMorty.character }
    location { Faker::RickAndMorty.location }

    initialize_with { User.new(name, location) }
  end
end
