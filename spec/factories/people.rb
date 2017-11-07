FactoryBot.define do
  factory :person do
    f_name { Faker::Name.first_name }
    l_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.free_email }
  end
end
