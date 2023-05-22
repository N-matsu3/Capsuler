class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.integer :user_id
      t.integer :tag_id
      t.integer :favorite_id
      t.integer :comment_id
      t.string :title
      t.text :detail
      #位置情報はどう持たせる？？

      t.timestamps
    end
  end
end
