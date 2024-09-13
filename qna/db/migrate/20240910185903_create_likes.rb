class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :rating, null: false, default: 0
      t.references :likable, polymorphic: true
      t.references :user

      t.timestamps
    end
  end
end
