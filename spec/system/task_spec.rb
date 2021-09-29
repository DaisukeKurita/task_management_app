require 'rails_helper'
describe 'タスク管理機能', type: :system do

  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:four_task)
    FactoryBot.create(:five_task)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        click_link '新しくタスクを作成する'
        fill_in 'タスク名', with: 'test_task_name'
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
        click_link '終了期限でソートする'
        task_list = all('table tr td')[0]
        expect(task_list).to have_content 'name_four'
      end
    end
    context '優先順位というリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスクが一番上に表示される' do
        click_link '優先順位'
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
