class CreateGoalComments < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_comments do |t|
      t.integer :author_id
      t.integer :subject_id
      t.text :comment

      t.timestamps
    end
   
  end
end
