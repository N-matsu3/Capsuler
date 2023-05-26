class TagRelation < ApplicationRecord
  belongs_to :item
  belongs_to :tag
end
