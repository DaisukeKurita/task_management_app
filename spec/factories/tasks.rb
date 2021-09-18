FactoryBot.define do
  factory :task do
    task_name { 'name' }
    task_detail { 'detail' }
  end
  factory :second_task, class: Task do
    task_name { 'name_second' }
    task_detail { 'detail_second' }
  end
  factory :third_task, class: Task do
    task_name { 'name_third' }
    task_detail { 'detail_third' }
  end
end
