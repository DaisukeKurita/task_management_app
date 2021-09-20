FactoryBot.define do
  factory :task do
    task_name { 'name' }
    task_detail { 'detail' }
    expired_at { '2021-09-23 17:06:00' }
  end
  factory :second_task, class: Task do
    task_name { 'name_second' }
    task_detail { 'detail_second' }
    expired_at { '2021-09-26 17:06:00' }
  end
  factory :third_task, class: Task do
    task_name { 'name_third' }
    task_detail { 'detail_third' }
    expired_at { '2021-09-25 17:06:00' }
  end
end
