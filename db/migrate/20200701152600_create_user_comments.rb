class CreateUserComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_comments do |t|
      t.integer :author_id
      t.integer :subject_id
      t.text :comment

      t.timestamps
    end
    add_index :user_comments, :author_id
    add_index :user_comments, :subject_id
  end
end
