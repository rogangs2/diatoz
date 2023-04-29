class CreateBlockedUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :blocked_users do |t|
      t.references :author, null: false, foreign_key: true
      t.references :subscriber, null: false, foreign_key: true

      t.timestamps
    end
  end
end
