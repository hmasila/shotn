class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :full_url
      t.string :vanity_string
      t.integer :clicks, default: 0
      t.boolean :deleted, default: false
      t.boolean :active, default: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
