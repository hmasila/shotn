class RenameLinksToLinkCount < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :links, :link_count
  end
end
