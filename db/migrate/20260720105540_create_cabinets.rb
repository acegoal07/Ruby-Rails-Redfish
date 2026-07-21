class CreateCabinets < ActiveRecord::Migration[8.1]
  def change
    create_table :cabinets do |t|
      t.string :name
      t.integer :u_size
      t.string :notes

      t.timestamps
    end
  end
end
