class Tag < ApplicationRecord
  
  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :tag_relations, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してitemテーブルへの関連付け
  has_many :items, through: :tag_relations, dependent: :destroy
  
end
