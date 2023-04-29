class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :subscriber, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
