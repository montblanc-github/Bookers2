class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # フォローした、フォローされたの関係
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :group_users
  has_many :group, through: :group_users

  attachment :profile_image

  validates :name,
    uniqueness: true,
    length: { minimum: 2, maximum: 20 }

  validates :introduction,
    length: { maximum: 50 }

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(other_user)
    followings.include?(other_user)
  end
end
