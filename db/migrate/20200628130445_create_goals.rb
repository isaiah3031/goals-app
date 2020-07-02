class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.integer :author_id
      t.boolean :private?, default: false
      t.text :text

      t.timestamps
    end
    add_index :goals, :author_id
  end
end
