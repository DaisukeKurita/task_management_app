FactoryBot.define do
  factory :label do
    label_name { "Cat" }
  end

  factory :second_label, class: Label do
    label_name { "Dog" }
  end

  factory :third_label, class: Label do
    label_name { "Pig" }
  end
end
