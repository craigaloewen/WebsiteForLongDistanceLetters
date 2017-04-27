class CreateLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :letters do |t|
      t.string :title
      t.text :text
      t.boolean :isArchived
      t.string :colour
      t.string :from
      t.string :link_token

      t.timestamps
    end
  end
end
