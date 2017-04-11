class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs do |t|
      t.string :language
      t.string :text

      t.timestamps
    end
  end
end
