class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.decimal :price

      t.timestamps null: false
    end
  end
end
