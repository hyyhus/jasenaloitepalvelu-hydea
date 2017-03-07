class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.datetime :time
      t.string :basket
      t.string :user_id
      t.string :idea_id
      t.belongs_to :idea, index: true

      t.timestamps null: false
    end
  end
end
