FactoryBot.define do
  factory :user do
    name { '山田' }
    email {'yamada56@gmail.com'}
    password {'123456'}
    password_confirmation {'123456'}
  end

  factory :second_user, class: User do
    name { '山田' }
    email {'yamada53@gmail.com'}
    password {'123456'}
    password_confirmation {'123456'}
  end

  factory :third_user, class: User do
    name { '山田' }
    email {'yamada54@gmail.com'}
    password {'123456'}
    password_confirmation {'123456'}
  end

end
