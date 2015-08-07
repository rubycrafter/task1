class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :head
      t.text   :content

      # The reference model itself is needed
      # for the tree structure
      t.references :suprapage, index: true

      t.timestamps null: false
    end
  end
end
