require 'rails_helper'
describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:second_task) }
  let!(:third_task) { FactoryBot.create(:third_task) }
  let!(:four_task) { FactoryBot.create(:four_task) }
  let!(:five_task) { FactoryBot.create(:five_task) }

  before do
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'test_task_name'
        fill_in 'タスク詳細', with: 'test_task_detail'
        fill_in '終了期限', with: Time.new
        select '完了'
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
        visit tasks_path(sort_expired: "true")
        task_list = all('table tr td')[0]
        expect(task_list).to have_content 'name_four'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(task.id)
         expect(page).to have_content 'name'
       end
     end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in '検索', with: 'four'
        click_button 'Search'
        expect(page).to have_content 'name_four'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中'
        click_button 'Search'
        expect(page).to have_content 'name_second'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in '検索', with: 'five'
        click_button 'Search'
        expect(page).to have_content 'name_five'
      end
    end
  end
end
