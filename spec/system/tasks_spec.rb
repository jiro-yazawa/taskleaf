require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧機能' do
    before do
      # ユーザーAを作成しておく
      # 作成者がAであるタスクを作成しておく
    end
    
    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
      end
    end
  end
end
