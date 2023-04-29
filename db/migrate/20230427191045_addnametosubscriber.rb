class Addnametosubscriber < ActiveRecord::Migration[7.0]
  def change
    add_column :subscribers, :name, :string
  end
end
