FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったタイトル1' }
    content {'Factoryで作ったコンテント1'}
    deadline {'2019-07-10'}
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったタイトル2'}
    content { 'Factoryで作ったコンテント2'}
    deadline {'2019-06-10'}
  end
end
