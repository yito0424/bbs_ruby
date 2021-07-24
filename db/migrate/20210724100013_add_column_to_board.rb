class AddColumnToBoard < ActiveRecord::Migration[5.0]
  def change
    # boardsテーブルのnameカラムを削除
    remove_column :boards, :name, :string
    # boardsテーブルにusersテーブルの参照キーを追加
    add_reference :boards, :user, foreign_key: true
  end
end
