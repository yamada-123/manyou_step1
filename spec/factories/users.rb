FactoryBot.define do
  factory :user do
    name { '山田' }
    email {'yamada1@gmail.com'}
    password {'123456'}
    password_confirmation {'123456'}
  end

  factory :second_user, class: User do
    name { '山田' }
    email {'yamada2@gmail.com'}
    password {'123456'}
    password_confirmation {'123456'}
  end

  factory :third_user, class: User do
    name { '山田' }
    email {'yamada3@gmail.com'}
    password {'123456'}
    password_confirmation {'123456'}
  end
  
end
