require 'rails_helper'
describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  
  before do
    visit root_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    visit tasks_path
  end

  describe 'ラベル新規作成機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        click_link 'ラベルの新規登録画面へ', match: :first
        fill_in 'ラベル名', with: 'Hamster'
        click_button '登録する'
        expect(page).to have_content 'Hamster'
      end
    end
  end
end