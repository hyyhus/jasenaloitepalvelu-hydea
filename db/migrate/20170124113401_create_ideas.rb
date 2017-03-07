class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :topic
      t.string :text      

      t.timestamps null: false
    end
  end
end
