class GroupUser < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, destroy: false
end