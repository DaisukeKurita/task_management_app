require 'rails_helper'
describe 'ユーザーの管理機能', type: :system do

  describe '一般ユーザー機能' do
    context '一般ユーザーを新規登録した場合' do
      it '新規登録をした一般ユーザーが表示される' do
        visit root_path
        click_link 'ユーザーの新規登録画面へ'
        fill_in 'ユーザー名', with: 'sample_name'
        fill_in 'メールアドレス', with: 'sample@gmail.com'
        fill_in 'パスワード', with: 'sample'
        fill_in 'パスワード確認', with: 'sample'
        click_button 'アカウントを作成する'
        expect(page).to have_content 'sample_name'
      end
    end

    context '一般ユーザーを登録しない場合' do
      it '一覧画面に飛ぼうとした時にログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end

    describe 'セッション機能' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:second_user) { FactoryBot.create(:second_user) }

      before do
        visit root_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context '一般ユーザーがログインをする場合' do
        it 'userでログインをする' do
          expect(page).to have_content 'komugi@gmail.com'
        end
      end

      context '一般ユーザーが自分の詳細画面(マイページ)に飛ぶ場合' do
        it '詳細画面(マイページ)に遷移する' do
          click_link 'Profile'
          expect(page).to have_content 'komugiのページ'
        end
      end

      context '一般ユーザが他人の詳細画面に飛ぼうとする場合' do
        it 'タスク一覧画面に遷移する' do
          visit user_path(user.id + 1)
          expect(page).to have_content 'タスク一覧'
        end
      end

      context '一般ユーザーがログアウトする場合' do
        it 'ログアウトする' do
          click_link 'Logout'
          expect(page).to have_content 'ログイン'
        end
      end
    end

    describe '管理ユーザー機能' do
      let!(:admin_user) { FactoryBot.create(:admin_user) }
      let!(:user) { FactoryBot.create(:user) }

      before do
        visit root_path
        fill_in 'メールアドレス', with: admin_user.email
        fill_in 'パスワード', with: admin_user.password
        click_button 'ログイン'
      end

      context '管理画面にアクセスをする場合' do
        it '管理ユーザーは管理画面にアクセスできる' do
          click_link 'ユーザー一覧画面へ'
          expect(page).to have_content 'ユーザー一覧'
        end

        it '一般ユーザーは管理画面にアクセスできない' do
          click_link 'Logout'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
          visit admin_users_path
          expect(page).to have_content 'タスク一覧'
        end

        context '管理ユーザーがユーザーの新規登録をする場合' do
          it '管理ユーザーはユーザーの新規登録ができる' do
            click_link 'ユーザー一覧画面へ'
            click_link 'ユーザー新規登録'
            fill_in 'ユーザー名', with: 'sample_name'
            fill_in 'メールアドレス', with: 'sample@gmail.com'
            fill_in 'パスワード', with: 'sample'
            fill_in 'パスワード確認', with: 'sample'
            click_button 'アカウントを作成する'
            expect(page).to have_content 'sample_name'
          end
        end

        context '管理ユーザーがユーザーの詳細画面にアクセスする場合' do
          it '管理ユーザーがユーザーの詳細画面にアクセスする' do
            click_link 'ユーザー一覧画面へ'
            all('tbody td')[9].click_link '詳細'
            expect(page).to have_content 'komugiのページ'
          end
        end

        context '管理ユーザーがユーザーの編集画面にアクセスする場合' do
          it '管理ユーザーがユーザーの情報を編集画面する' do
            click_link 'ユーザー一覧画面へ'
            all('tbody td')[10].click_link '編集'
            fill_in 'ユーザー名', with: 'sample_name'
            fill_in 'メールアドレス', with: 'sample@gmail.com'
            fill_in 'パスワード', with: 'sample'
            fill_in 'パスワード確認', with: 'sample'
            click_button 'アカウントを作成する'
            expect(page).to have_content 'sample_name'
          end
        end

        context '管理ユーザーがユーザの削除をする場合' do
          it '管理ユーザーがユーザーを削除する' do
            click_link 'ユーザー一覧画面へ'
            all('tbody td')[11].click_link '削除'
            expect(page).to have_content 'ユーザーは正常に削除されました'
          end
        end
      end
    end
  end
end
