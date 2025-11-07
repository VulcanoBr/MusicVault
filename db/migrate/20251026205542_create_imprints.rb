class CreateImprints < ActiveRecord::Migration[7.2]
  def change
    create_table :imprints do |t|
      t.string :name, null: false # Ex: 'EMI', 'Capitol', 'Atlantic'
      t.timestamps
    end
    add_index :imprints, :name, unique: true
  end
end
