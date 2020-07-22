require "faker"
require_relative "../models/user_model"

FactoryBot.define do
  factory :user, class: UserModel do
    full_name { "Edson Boaro" }
    email { "edsonboaro@teste.com" }
    password { "teste123" }

    after(:build) do |user|
      #puts "apagando o email " + user.email
      Database.new.delete_user(user.email)
    end
  end

  factory :registered_user, class: UserModel do
    id { 0 }
    full_name { Faker::Movies::StarWars.character }
    email { Faker::Internet.free_email(name: full_name) }
    password { "teste123" }

    after(:build) do |user|
      #puts "apagando o email " + user.email
      Database.new.delete_user(user.email)
      result = ApiUser.save(user.to_hash)
      user.id = result.parsed_response["id"]
    end
  end

  factory :user_wrong_email, class: UserModel do
    full_name { "Edson Boaro" }
    email { "edsonboaro#teste.com" }
    password { "teste123" }
  end

  factory :empty_name_user, class: UserModel do
    full_name { "" }
    email { "edsonboaro@teste.com" }
    password { "teste123" }
  end

  factory :empty_email_user, class: UserModel do
    full_name { "Edson Boaro" }
    email { "" }
    password { "teste123" }
  end

  factory :empty_password_user, class: UserModel do
    full_name { "Edson Boaro" }
    email { "edsonboaro@teste.com" }
    password { "" }
  end

  factory :null_name_user, class: UserModel do
    email { "edsonboaro@teste.com" }
    password { "teste123" }
  end

  factory :null_email_user, class: UserModel do
    full_name { "Edson Boaro" }
    password { "teste123" }
  end

  factory :null_password_user, class: UserModel do
    full_name { "Edson Boaro" }
    email { "edsonboaro@teste.com" }
  end
end
