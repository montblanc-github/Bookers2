class Relationship < ApplicationRecord
  # 正しくuserテーブルを参照させるため、class_nameを指定
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
