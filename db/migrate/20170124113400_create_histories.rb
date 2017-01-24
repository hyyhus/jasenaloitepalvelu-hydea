class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.datetime :time
      t.string :basket_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
