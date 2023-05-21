class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.integer :tag_id
      t.integer :favorite_id
      t.integer :comment_id
      t.string :title
      t.text :detail

      t.timestamps
    end
  end
end
