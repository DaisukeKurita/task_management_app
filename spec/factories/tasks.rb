FactoryBot.define do
  factory :task do
    task_name { 'name' }
    task_detail { 'detail' }
    expired_at { '2021-09-23 17:06:00' }
    status { 'not_started_yet' }
  end

  factory :second_task, class: Task do
    task_name { 'name_second' }
    task_detail { 'detail_second' }
    expired_at { '2021-09-26 17:06:00' }
    status { 'under_start' }
  end

  factory :third_task, class: Task do
    task_name { 'name_third' }
    task_detail { 'detail_third' }
    expired_at { '2021-09-25 17:06:00' }
    status { 'completion' }
  end

  factory :four_task, class: Task do
    task_name { 'name_four' }
    task_detail { 'detail_four' }
    expired_at { '2021-12-15 17:06:00' }
    status { 'not_started_yet' }
  end

  factory :five_task, class: Task do
    task_name { 'name_five' }
    task_detail { 'detail_five' }
    expired_at { '2021-11-25 17:06:00' }
    status { 'under_start' }
  end
end
