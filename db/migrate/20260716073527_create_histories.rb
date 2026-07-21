class CreateHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :histories do |t|
      t.integer :server_id
      t.string :system_name
      t.string :system_model
      t.string :system_uuid
      t.integer :memory_total_gib
      t.string :cpu_model
      t.integer :cpu_count
      t.integer :core_count
      t.integer :logical_core_count
      t.string :bios_version
      t.integer :slot
      t.integer :cabinet_id
      t.string :u_position
      t.json :json
      t.string :notes

      t.timestamps
    end

    add_foreign_key :histories, :servers, column: :server_id
    add_foreign_key :histories, :cabinets, column: :cabinet_id
  end
end
