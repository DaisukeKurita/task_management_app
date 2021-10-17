FactoryBot.define do
  factory :user do
     user_name { 'komugi' }
     email { 'komugi@gmail.com' }
     password { 'komugi' }
     admin { 'false' }
  end

  factory :second_user, class: User do
     user_name { 'daikon' }
     email { 'daikon@gmail.com' }
     password { 'daikon' }
     admin { 'false' }
  end

  factory :admin_user, class: User do
     user_name { 'oomugi' }
     email { 'oomugi@gmail.com' }
     password { 'oomugi' }
     admin { 'true' }
  end
end
