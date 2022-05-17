FactoryBot.define do 
  factory :chirp do 
    body { "NO COVID, PLEASE!" }
    association :author, factory: :user
  end
end