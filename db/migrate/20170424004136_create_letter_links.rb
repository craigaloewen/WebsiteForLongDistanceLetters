class CreateLetterLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :letter_links do |t|
      t.integer :letters_number
      t.string :token
      t.references :jar, foreign_key: true

      t.timestamps
    end
    add_index :letter_links, :token, unique: true
  end
end
