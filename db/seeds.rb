require 'factory_bot'

#ユーザーサンプル作成
FactoryBot.create(:admin_user)

9.times do |n|
FactoryBot.create(
    :user,
    user_name: "test#{n + 1}",
    email: "test#{n + 1}@gmail.com",
    password: "password",
    admin: false
  )
end

# タスクサンプル作成
@task1 = FactoryBot.create(:task, user_id: 2)
@task2 = FactoryBot.create(:second_task, user_id: 3)
@task3 = FactoryBot.create(:third_task, user_id: 4)
@task4 = FactoryBot.create(:four_task, user_id: 5)
@task5 = FactoryBot.create(:five_task, user_id: 6)
@task6 = FactoryBot.create(:task, user_id: 7)
@task7 = FactoryBot.create(:second_task, user_id: 8)
@task8 = FactoryBot.create(:third_task, user_id: 9)
@task9 = FactoryBot.create(:four_task, user_id: 10)
@task10 = FactoryBot.create(:five_task, user_id: 2)

# ラベルサンプル作成
@label1 = FactoryBot.create(:label, user_id: 2)
@label2 = FactoryBot.create(:second_label, user_id: 3)
@label3 = FactoryBot.create(:third_label, user_id: 4)
@label4 = FactoryBot.create(:label, label_name: "Hamster", user_id: 5)
@label5 = FactoryBot.create(:label, label_name: "Monkey", user_id: 2)
@label6 = FactoryBot.create(:label, label_name: "Tiger", user_id: 3)
@label7 = FactoryBot.create(:label, label_name: "Lion", user_id: 4)
@label8 = FactoryBot.create(:label, label_name: "Llephant", user_id: 5)
@label9 = FactoryBot.create(:label, label_name: "Dinosaur", user_id: 6)
@label10 = FactoryBot.create(:label, label_name: "Shark", user_id: 6)

# タスクとラベルのアソシエーション
FactoryBot.create(:labelling, task_id: @task1.id, label_id: @label1.id )
FactoryBot.create(:labelling, task_id: @task1.id, label_id: @label5.id )
FactoryBot.create(:labelling, task_id: @task2.id, label_id: @label2.id )
FactoryBot.create(:labelling, task_id: @task2.id, label_id: @label6.id )
FactoryBot.create(:labelling, task_id: @task3.id, label_id: @label3.id )
FactoryBot.create(:labelling, task_id: @task3.id, label_id: @label7.id )
FactoryBot.create(:labelling, task_id: @task4.id, label_id: @label4.id )
FactoryBot.create(:labelling, task_id: @task4.id, label_id: @label7.id )
FactoryBot.create(:labelling, task_id: @task5.id, label_id: @label9.id )
FactoryBot.create(:labelling, task_id: @task5.id, label_id: @label10.id )