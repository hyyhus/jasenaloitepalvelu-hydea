class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :user_id
      t.datetime :time
      t.string :text
      t.string :idea_id

      t.timestamps null: false
    end
  end
end
