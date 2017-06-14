class CreateJars < ActiveRecord::Migration[5.0]
  def change
    create_table :jars do |t|
      t.string :site_url
      t.datetime :unlock_time
      t.integer :refresh_rate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
