class CreateFruits < ActiveRecord::Migration[5.0]
  def change
    create_table :fruits do |t|
      t.string :title
      t.integer :amount

      t.timestamps
    end
  end
end
