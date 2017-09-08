class CreateJars < ActiveRecord::Migration[5.0]
  def change
    create_table :jars do |t|
      t.string :site_url
      t.datetime :unlock_time
      t.integer :refresh_rate
      t.string :password_digest
      t.boolean :is_secured
      t.string :encrypted_jar_password
      t.timestamps
    end
    add_index :jars, :site_url, unique: true
  end
end
