class CreateLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :letters do |t|
      t.string :title
      t.text :text
      t.boolean :is_archived
      t.string :colour
      t.string :from
      t.string :link_token
      t.references :jar, foreign_key: true

      t.timestamps
    end
  end
end
