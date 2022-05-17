FactoryBot.define do 
  factory :user do 
    username { Faker::Movies::StarWars.character }
    email { Faker::Internet.email }
    age { 20 }
    political_affiliation { Faker::Movies::StarWars.planet }
    password { 'starwars' }
  end

  factory :luke_skywalker do 
    username { 'Luke Skywalker' }
  end
  
end