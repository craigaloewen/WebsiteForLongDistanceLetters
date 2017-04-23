class CreateLoveLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :love_letters do |t|
      t.string :title
      t.text :text
      t.boolean :isArchived
      t.string :colour
      t.timestamps
    end
  end
end
