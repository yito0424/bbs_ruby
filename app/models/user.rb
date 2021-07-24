# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#

class User < ApplicationRecord
    has_many :boards, dependent: :delete_all
    has_many :comments, dependent: :delete_all
    # password属性とpassword_confirmation属性の追加
    # passwordとpasswrod_confirmationの値が一致しているかをvalidationでチェックしてくれる
    has_secure_password

    validates :name,
        presence: true,
        uniqueness: true,
        length: { maximum: 16 },
        format: {
            with: /\A[a-z0-9]+\z/,
            message: 'は小文字英数字で入力してください'
        } 
    validates :password,
        # minimumを設定することで自動的にpresence trueとなる
        length: { minimum: 8 }
end
