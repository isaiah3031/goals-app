class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :comment, polymorphic: true
      t.timestamps
    end
  end
end
