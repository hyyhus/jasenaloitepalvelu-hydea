class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :like_type
      t.string :user_id
      t.string :idea_id

      t.timestamps null: false
    end
  end
end
