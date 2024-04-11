class CreateProductModels < ActiveRecord::Migration[7.1]
  def change
    create_table :product_models do |t|
      t.string :name
      t.integer :weigth
      t.integer :width
      t.integer :heigth
      t.integer :depth
      t.string :sku
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
