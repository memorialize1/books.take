class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|

      t.references :user, foreign_key: true #外部キー取得のコマンド。異なるモデルのテーブルの情報を識別する。これでusersのテーブルと紐づけ
      t.references :follow, foreign_key: { to_table: :users } #カラムfollowのデータでusersのテーブル参照

      t.timestamps

      t.index [:user_id, :follow_id], unique: true #このペアで同じID同士が重複して保存されないための設定
    end
  end
end
