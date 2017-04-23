class CreateUnlockTimeHolders < ActiveRecord::Migration[5.0]
  def change
    create_table :unlock_time_holders do |t|
      t.datetime :unlockTime

      t.timestamps
    end
  end
end
