class Group < ApplicationRecord
  belongs_to :user
  belongs_to :group
  attachment :image
end
