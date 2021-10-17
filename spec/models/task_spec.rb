require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', task_detail: '失敗テスト', user_id: user.id)
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: '失敗テスト', task_detail: '', user_id: user.id)
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: '失敗テスト', task_detail: '失敗テスト',  user: user)
        expect(task).to be_valid
      end
    end
  end

  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
      let!(:task) { FactoryBot.create(:task, user: user) }
      let!(:second_task) { FactoryBot.create(:second_task, user: user) }
      let!(:third_task) { FactoryBot.create(:third_task, user: user) }
      let!(:four_task) { FactoryBot.create(:four_task, user: user) }
      let!(:five_task) { FactoryBot.create(:five_task, user: user) }

      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          expect(Task.search_task_name('name_second')).to include(second_task)
          expect(Task.search_task_name('name_second')).not_to include(third_task)
          expect(Task.search_task_name('name_second').count).to eq 1
        end
      end

      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          expect(Task.search_status('completion')).to include(third_task)
          expect(Task.search_status('completion')).not_to include(four_task)
          expect(Task.search_status('completion').count).to eq 1
        end
      end

      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          expect(Task.search_task_name('name_f').search_status('under_start')).to include(five_task)
          expect(Task.search_task_name('name_f').search_status('under_start')).not_to include(four_task)
          expect(Task.search_task_name('name_f').search_status('under_start').count).to eq 1
        end
      end
    end
  end
end
