class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :micropost_id
      t.string :image_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
