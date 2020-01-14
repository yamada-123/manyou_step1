FactoryBot.define do
  factory :label do
    classification { 'HTML' }
  end
  factory :second_label, class: Label do
    classification {'CSS'}
  end
  factory :third_label, class: Label do
    classification{'Ruby'}
  end
end
