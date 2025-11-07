class CreateCountries < ActiveRecord::Migration[7.2]
  def change
    create_table :countries do |t|
      t.string :name, null: false # Ex: 'Brazil', 'USA'
      t.string :code, null: false # Ex: 'BR', 'US'
      t.string :flag_code
      t.timestamps
    end
    add_index :countries, :code, unique: true
  end
end
