class Item < ApplicationRecord

  has_one_attached :image

  validates :title, presence: true
  validates :detail, presence: true
   validates :address, presence: true
  # validates :image, presence: true

  belongs_to :user

  #itemsテーブルから中間テーブルに対する関連付け
  has_many :tag_relations, dependent: :destroy
  #itemsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :tag_relations, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  geocoded_by :address
  after_validation :geocode

end