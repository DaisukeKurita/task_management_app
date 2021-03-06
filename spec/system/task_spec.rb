require 'rails_helper'
describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  
  before do
    @task1 = FactoryBot.create(:task, user: user)
    @task2 = FactoryBot.create(:second_task, user: user)
    @task3 = FactoryBot.create(:third_task, user: user)
    @task4 = FactoryBot.create(:four_task, user: user)
    @task5 = FactoryBot.create(:five_task, user: user)
    @label1 = FactoryBot.create(:label, user: user)
    @label2 = FactoryBot.create(:second_label, user: user)
    @label3 = FactoryBot.create(:third_label, user: user)
    FactoryBot.create(:labelling, task_id: @task1.id, label_id: @label1.id )
    FactoryBot.create(:labelling, task_id: @task1.id, label_id: @label2.id )
    FactoryBot.create(:labelling, task_id: @task2.id, label_id: @label3.id )
    FactoryBot.create(:labelling, task_id: @task3.id, label_id: @label1.id )
    FactoryBot.create(:labelling, task_id: @task4.id, label_id: @label2.id )
    visit root_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        click_link '新しくタスクを作成する', match: :first
        fill_in 'タスク名', with: 'test_task_name'
        check "task_label_ids_#{(@label1.id)}"
        check "task_label_ids_#{(@label2.id)}"
        fill_in 'タスク詳細', with: 'test_task_detail'
        fill_in '終了期限', with: Time.new
        select '完了'
        select '中'
        click_button '登録する'
        expect(page).to have_content 'test_task_name'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'name'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('table tr td')[0]
        expect(task_list).to have_content 'name_five'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスクが一番上に表示される' do
        sleep 0.5
        click_link '終了期限'
        sleep 0.5
        task_list = all('table tr td')[0]
        expect(task_list).to have_content 'name_four'
      end
    end
    context '優先順位というリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスクが一番上に表示される' do
        sleep 0.5
        click_link '優先順位'
        sleep 0.5
        task_list = all('table tr td')[0]
        expect(task_list).to have_content 'name_third'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         click_link '詳細', match: :first
         expect(page).to have_content 'five'
       end
     end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'タスク名検索', with: 'four'
        click_button '検索'
        expect(page).to have_content 'name_four'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中'
        click_button '検索'
        expect(page).to have_content 'name_second'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        fill_in 'タスク名検索', with: 'five'
        click_button '検索'
        expect(page).to have_content 'name_five'
      end
    end
    context 'タイトルのあいまい検索とステータス検索とラベル検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータス・ラベルに完全一致するタスクが絞り込まれる" do
        fill_in 'タスク名検索', with: 'third'
        select '完了'
        select 'Cat'
        click_button '検索'
        expect(page).to have_content 'name_third'
      end
    end
    context 'タイトルのあいまい検索とラベル検索をした場合' do
      it "検索キーワードをタイトルに含み、かつラベルに完全一致するタスクが絞り込まれる" do
        fill_in 'タスク名検索', with: 'name_four'
        select 'Dog'
        click_button '検索'
        expect(page).to have_content 'name_four'
      end
    end
    context 'ステータス検索とラベル検索をした場合' do
      it "ステータス・ラベルに完全一致するタスクが絞り込まれる" do
        select '着手中'
        select 'Pig'
        click_button '検索'
        expect(page).to have_content 'name_second'
      end
    end
    context 'ラベル検索をした場合' do
      it "ラベルに完全一致するタスクが絞り込まれる" do
        select 'Pig'
        click_button '検索'
        expect(page).to have_content 'name_second'
      end
    end
  end
end
