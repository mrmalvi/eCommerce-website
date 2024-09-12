class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.text :colors
      t.text :sizes
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
