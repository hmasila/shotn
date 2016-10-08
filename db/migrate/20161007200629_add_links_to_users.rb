class AddLinksToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :links, :integer, default: 0
  end
end
