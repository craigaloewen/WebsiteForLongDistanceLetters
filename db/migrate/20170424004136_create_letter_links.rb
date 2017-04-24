class CreateLetterLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :letter_links do |t|
      t.integer :numLetters
      t.string :token

      t.timestamps
    end
  end
end
