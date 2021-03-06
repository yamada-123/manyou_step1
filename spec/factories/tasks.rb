FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったタイトル1' }
    content {'Factoryで作ったコンテント1'}
    deadline {'2019-07-10'}
    status {'未着手'}
    priority {'1'}
    user_id {'1'}
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったタイトル2'}
    content { 'Factoryで作ったコンテント2'}
    deadline {'2019-06-10'}
    status {'完了'}
    priority {'3'}
    user_id {'1'}
  end

  factory :third_task, class: Task do
    title { 'Factoryで作ったタイトル3'}
    content { 'Factoryで作ったコンテント3'}
    deadline { '2019-05-10'}
    status {'着手中'}
    priority {'2'}
    user_id{'2'}
  end

  factory :fourth_task, class: Task do
    title { 'Factoryで作ったタイトル4'}
    content { 'Factoryで作ったコンテント4'}
    deadline { '2019-05-10'}
    status {'着手中'}
    priority {'2'}
    middles_label_ids {['1','2']}
    user_id{'2'}
  end
end

