class CreateJars < ActiveRecord::Migration[5.0]
  def change
    create_table :jars do |t|
      t.string :siteurl
      t.datetime :unlockTime
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
