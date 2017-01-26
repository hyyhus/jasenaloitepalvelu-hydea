class CreateTags < ActiveRecord::Migration
	def change
		create_table :tags do |t|
			t.string :text

			t.timestamps null: false
		end

#		create_table :ideas_tags, id: false do |t|
#			t_belogs_to :idea, index: true
#			t_belogs_to :tag, index: true

		end


	end
