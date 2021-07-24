class AddColumnToComment < ActiveRecord::Migration[5.0]
  def change
    # commentsテーブルのnameカラムを削除
    remove_column :comments, :name, :string
    # commentsテーブルにusersテーブルの参照キーを追加
    add_reference :comments, :user, foreign_key: true
  end
end
