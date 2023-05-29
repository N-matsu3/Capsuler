class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  #itemsテーブルから中間テーブルに対する関連付け
  has_many :tag_relations, dependent: :destroy
  #itemsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :tag_relations, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  

end
