class CreateHabituations < ActiveRecord::Migration[6.1]
  def change
    create_table :habituations do |t|
      t.string :title
      t.string :slack_notification

      t.timestamps
    end
  end
end
